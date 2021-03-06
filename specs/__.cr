
require "da_spec"
require "file_utils"
require "../src/my_js"
require "inspect_bang"

extend DA_SPEC

def reset_fs
  dir = "tmp/in/specs_tmp"
  FileUtils.rm_rf(dir)
  Dir.mkdir_p(dir)
  Dir.cd(dir) {
    yield
  }
end # === def reset_fs

describe ".new" do

  it "sets .dir to closes parent dir" do
    j = My_JS::File.new([] of String, "/a/b/c/d.js")
    assert j.dir == "c"
  end # === it "sets .dir"

  it "sets .name" do
    j = My_JS::File.new([] of String, "/a/b.js")
    assert j.name == "b"
  end # === it "sets .name"

  it "sets .extname" do
    j = My_JS::File.new([] of String, "/a/b.js")
    assert j.extname == ".js"

    j = My_JS::File.new([] of String, "/a/b.jspp")
    assert j.extname == ".jspp"
  end # === it "sets .extname"

end # === desc ".new"
describe ".compile" do
  it "returns a DA_Process" do
    reset_fs {
      File.write(
        "a.jspp", <<-EOF
          import System.Console;
          Console.log("loaded root");
        EOF
      )
      f = My_JS::File.new([] of String, "a.jspp")
      actual = f.compile("a.js")
      assert actual.success? == true
    }
  end # === it "returns a DA_Process with output"

  it "writes file" do
    reset_fs {
      File.write(
        "a.jspp", <<-EOF
          import System.Console;
          Console.log("it works");
        EOF
      )
      f = My_JS::File.new([] of String, "a.jspp")
      f.compile("a.js")
      expect = %{System.Console.jsConsoleThis,["it works"]);}
      assert File.read("a.js")[expect]? == expect
    }
  end # === it "writes file"
end # === desc ".compile"
