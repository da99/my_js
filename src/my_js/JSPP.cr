
require "http/client"

module My_JS
  class JSPP

    BIN = "#{THIS_DIR}/tmp/JS++/js++"

    # =============================================================================
    # Class:
    # =============================================================================

    def self.exec!(args : Array(String))
      Process.exec(BIN, args)
    end

    def self.version
      proc = DA_Process.new(BIN, "--version".split).success!
      proc.output
    end

    def self.latest_version
      resp = DA_Process.new("curl", ["-s", "https://www.onux.com/jspp/"]).success!.output.to_s
      tmp = Deque(String).new
      resp.lines.each { |l|
        next unless l["Version"]?
        pieces = l.split
        tmp.push(pieces[2]) if pieces[2]?
      }
      version = tmp.pop
      if version.is_a?(String) && version[/\A\d+\.\d+\.\d+\Z/]?
        version
      else
        STDERR.puts "!!! Could not retrieve version: #{version.inspect}"
        exit 1
      end
    end


    # =============================================================================
    # Instance:
    # =============================================================================

  end # === class JSPP
end # === module My_JS
