
ENV["PATH"] = "#{ENV["PATH"]}:#{THIS_DIR}/tmp/out/JS++"

module My_JS
  class JSPP

    BIN = "js++"

    # =============================================================================
    # Class:
    # =============================================================================

    def self.exec!(args : Array(String))
      Process.exec(BIN, args)
    end

    def self.version
      proc = DA_Process.new(BIN, "--version".split).success!
      proc.output.to_s.gsub("JS++(tm) v.", "").strip
    end

    def self.latest_version
      resp = DA_Process.new("curl", ["-s", "https://www.onux.com/jspp/"]).success!.output.to_s
      version = nil
      resp.lines.each { |l|
        next unless l["Version"]?
        pieces = l.split
        if pieces[2]? && pieces[2][/\A\d+\.\d+\.\d+\Z/]?
          version = pieces[2]
          break
        end
      }
      if version.is_a?(String)
        version
      else
        STDERR.puts "!!! Could not retrieve version: #{version.inspect}"
        exit 1
      end
    end

    def self.install
      target_version = latest_version
      url="https://onux.r.worldssl.net/jspp/downloads/JS++-#{target_version}-linux_x64.tar.gz"
      file_name = File.basename(url)
      tmp = "tmp/out"
      Dir.cd(THIS_DIR)
      Dir.mkdir_p tmp
      Dir.cd tmp
      bin = "JS++/#{BIN}"

      if !File.exists?(bin) || version != target_version
        File.delete(file_name) if File.exists?(file_name)
        DA_Process.success!("wget", [url])
        DA_Process.success!("tar", ["-xzf", file_name])
      end

      if File.exists?(bin)
        DA_Dev.green! "=== {{DONE}}: BOLD{{#{bin}}} #{version}"
      else
        DA_Dev.orange! "=== {{Files installed}}: but executable not found: BOLD{{#{bin}}} "
        exit 1
      end
    end # === def self.install


    # =============================================================================
    # Instance:
    # =============================================================================

  end # === class JSPP
end # === module My_JS
