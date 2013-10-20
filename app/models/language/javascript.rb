Language.define "Javascript" do |lang|
  lang.name = "Javascript"
  lang.extension = "js"
  lang.image = "bouk/node"
  lang.build = "echo 'hello world'"
  lang.run = "node /sandbox/file.js"
end
