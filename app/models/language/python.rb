Language.define "Python" do |lang|
  lang.extension = "py"
  lang.image = "bouk/python"
  lang.build = "python -c \"from subprocess import check_output;import py_compile;py_compile.compile('/sandbox/file.py',cfile=check_output(['mktemp']).strip(), doraise=True)\""
  lang.run = "python /sandbox/file.py"
end
