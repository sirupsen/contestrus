Language.define "Javascript" do |lang|
  lang.extension = "js"
  lang.image = "bouk/node"
  lang.build = "echo 'hello world'"
  lang.run = "node /sandbox/file.js"
  lang.version = "node --version"
end
