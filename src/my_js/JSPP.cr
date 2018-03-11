
ENV["PATH"] = "#{ENV["PATH"]}:#{__DIR__}/../tmp/out/JS++"

module My_JS
  module JSPP
    extend self

    def exec!(args)
      Process.exec("js++", args)
    end

    def compile(args : Array(String))
      if !DA_Process.new("which", ["js++"]).success?
        raise Error.new("Not found in patch: js++")
      end
      DA_Process.new("js++", args)
    end

    def version
      DA_Process.new("js++", "--version".split).success!.output.to_s.gsub("JS++(tm) v.", "").strip
    end

    def latest_version
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
        raise Error.new("Could not retrieve version: #{version.inspect}")
      end
    end

    def install(dir)
      target_version = latest_version
      url="https://onux.r.worldssl.net/jspp/downloads/JS++-#{target_version}-linux_x64.tar.gz"
      file_name = ::File.basename(url)

      Dir.mkdir_p dir
      Dir.cd(dir)
      bin = ::File.join(dir, "JS++/js++")

      if !::File.exists?(bin) || version != target_version
        ::File.delete(file_name) if ::File.exists?(file_name)
        DA_Process.success!("wget", [url])
        DA_Process.success!("tar", ["-xzf", file_name])
      end

      if ::File.exists?(bin)
        DA_Dev.green! "=== {{DONE}}: BOLD{{#{bin}}} #{version}"
      else
        DA_Dev.orange! "=== {{Files installed}}: but executable not found: BOLD{{#{bin}}} "
        exit 1
      end
    end # === def install

  end # === class JSPP
end # === module My_JS
