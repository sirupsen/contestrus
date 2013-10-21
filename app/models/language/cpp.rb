Language.define "C++" do |lang|
  lang.extension = "cpp"
  lang.image = "bouk/gcc"
  lang.build = "g++ -std=c++11 -O2 -o /binary /sandbox/file.cpp"
  lang.run = "/binary"
  lang.version = "g++ --version"
end
