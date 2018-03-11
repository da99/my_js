
require "da_dev"
THIS_DIR = File.expand_path("#{__DIR__}/..")
require "../src/my_js"


full_cmd = ARGV.join(' ')
args = ARGV.dup
cmd = args.shift

case
when %w[-h help --help].includes?(full_cmd)
  # === {{CMD}} -h|help|--help
  DA_Dev::Documentation.print_help([__FILE__])

when cmd == "install" && args.size == 1
  # === {{CMD}} install /dir/to/install/to # install JS++
  My_JS::JSPP.install(args.last)

when full_cmd == "js++ version"
  # === {{CMD}} version
  puts My_JS::JSPP.version

when full_cmd == "js++ version latest"
  # === {{CMD}} latest version
  puts My_JS::JSPP.latest_version

when cmd == "js++" && !args.empty?
  # === {{CMD}} __ my args to js++ binary
  My_JS::JSPP.exec!(args)

when cmd == "init" && args.empty?
  # === {{CMD}} init
  _yarnrc = ".yarnrc"
  if File.exists?(_yarnrc)
    DA_Dev.green! "=== {{Already exists}}: BOLD{{#{_yarnrc}}}"
  else
    File.open(_yarnrc, "a") { |f|
      f.puts %{--install.modules-folder "./.js_packages"}
      f.puts %{--upgrade.modules-folder "./.js_packages"}
    }
    DA_Dev.green! "=== BOLD{{Wrote}}: {{#{_yarnrc}}}"
  end

else
  DA_Dev.red! "!!! Invalid arguments: BOLD{{#{ARGV.map(&.inspect).join " "}}}"
  exit 1

end # === case
