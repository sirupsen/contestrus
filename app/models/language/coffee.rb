Language.define "Coffee" do |lang|
  lang.extension = "coffee"
  lang.image = "bouk/coffee"
  lang.build = "coffee -c -o /tmp /sandbox/file.coffee"
  lang.run = "node /tmp/file.js"
end
