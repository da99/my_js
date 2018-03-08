
require "da_dev"
require "../src/my_js"


full_cmd = ARGV.join(' ')
args = ARGV.dup
cmd = args.shift

case
when %w[-h help --help].includes?(full_cmd)
  # === {{CMD}} -h|help|--help
  DA_Dev::Documentation.print_help([__FILE__])

when full_cmd == "js++ install"
  # === {{CMD}} install # install JS++
  My_JS::JSPP.install

when full_cmd == "js++ version"
  # === {{CMD}} version
  puts My_JS::JSPP.version

when full_cmd == "js++ version latest"
  # === {{CMD}} latest version
  puts My_JS::JSPP.latest_version

when cmd == "js++"
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
    }
    DA_Dev.green! "=== BOLD{{Wrote}}: {{#{_yarnrc}}}"
  end

else
  DA_Dev.red! "!!! Invalid arguments: BOLD{{#{ARGV.map(&.inspect).join " "}}}"
  exit 1

end # === case
