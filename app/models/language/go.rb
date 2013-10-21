Language.define "Go" do |lang|
  lang.extension = "go"
  lang.image = "bouk/golang"
  lang.build = "go build -o /binary /sandbox/file.go"
  lang.run = "/binary"
  lang.version = "go version"
end
