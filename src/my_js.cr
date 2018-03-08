
THIS_DIR = File.expand_path("#{__DIR__}/..")
ENV["PATH"] = "#{ENV["PATH"]}:#{THIS_DIR}/tmp/bin"

require "./my_js/*"
