
require "shell_out"

case ARGV[0]?
when "compile"
  puts ARGV.inspect
else
  STDERR.puts "!!! Invalid args: #{ARGV.map(&.inspect).join " "}"
  exit 1
end
