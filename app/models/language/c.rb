Language.define "C" do |lang|
  lang.extension = "c"
  lang.image = "bouk/gcc"
  lang.build = "gcc -std=c99 -O2 -o /binary /sandbox/file.c"
  lang.run = "/binary"
  lang.version = "gcc --version"
end
