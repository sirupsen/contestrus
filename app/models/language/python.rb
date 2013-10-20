Language.define "Python" do |lang|
  lang.extension = "py"
  lang.image = "bouk/pypy"
  lang.build = "pypy -c \"from subprocess import check_output;import py_compile;py_compile.compile('/sandbox/file.py',cfile=check_output(['mktemp']).strip(), doraise=True)\""
  lang.run = "pypy /sandbox/file.py"
end
