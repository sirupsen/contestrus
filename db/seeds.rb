YAML.load_file("./test/fixtures/languages.yml").each do |key, value|
  Language.create!(value)
end
