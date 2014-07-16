Language.define "Java" do |lang|
  lang.extension = "java"
  lang.image = "rangalo/java7"
  lang.build = "javac /sandbox/Solution.java  -d /binary -s /binary"
  lang.run = "/binary"
  lang.version = "java -version"
end
