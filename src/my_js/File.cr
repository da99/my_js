
module My_JS
  struct File

    getter path : String
    getter dir  : String
    getter ext  : String
    getter name : String
    getter libs : Array(String)

    def initialize(@libs, @path)
      @dir  = ::File.basename(::File.dirname(@path))
      @ext  = ::File.extname(@path).downcase
      @name = ::File.basename(@path, ::File.extname(@path))
    end # === def initialize

    def compile(outfile : String)
      case
      when jspp?
        args = libs.dup
        args.push path
        args.push "-o"
        args.push outfile
        Dir.mkdir_p(::File.dirname(outfile))
        JSPP.compile(args)
      else
        raise Error.new("Unknown file type: #{path}")
      end
    end # === def compile!

    {% for x in %w[jspp].map(&.id) %}
      def {{x}}?
        @ext == ".{{x}}"
      end
    {% end %}

  end # === struct File
end # === module My_JS
