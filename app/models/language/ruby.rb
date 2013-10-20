Language.define "ruby" do |lang|
  lang.extension = "rb"
  lang.image = "bouk/ruby"
  lang.build = "ruby -c /sandbox/file.rb"
  lang.run = "ruby /sandbox/file.rb"
end
