
require "da_dev"
require "../src/my_js"

full_cmd = ARGV.join(' ')
args = ARGV.dup
cmd = args.shift

case
when %w[-h help --help].includes?(full_cmd)
  # === {{CMD}} -h|help|--help
  DA_Dev::Documentation.print_help([__FILE__])

when cmd == "init" && args.empty?
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
  DA_Dev.red! "!!! Invalid arguments: BOLD{{#{ARGV.inspect}}}"
  exit 1

end # === case
