sirup = User.create!(username: "sirup", password: "seekrit", admin: true, email: 'whoever@example.com')
YAML.load_file("./test/fixtures/languages.yml").each do |key, value|
  Language.create!(value)
end
