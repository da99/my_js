
ENV["PATH"] = "#{ENV["PATH"]}:#{__DIR__}/../tmp/out/JS++"

require "da_process"
require "./my_js/*"
module My_JS
  class Error < Exception
  end
end # === module My_JS
