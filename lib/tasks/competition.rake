namespace :competition do
  desc "Import a competition into the database"
  task :import, [:path] => [:environment] do |t, args|
    competition_info = YAML.load_file(args[:path] + "/competition.yml")
    competition = Competition.find_by_name(competition_info["name"])

    unless competition
      competition = Competition.create(competition_info)
    end

    puts "Competition: #{competition.name}"

    Dir.glob("#{args[:path]}/**/task.yml").sort.each do |task|
      info = YAML.load_file(task)

      if Task.find_by_name(info["name"])
        puts "\t#{info["name"]} already exists"
        next
      end

      puts "\tAdding #{info["name"]}"

      task_obj = competition.tasks.create(name: info["name"],
                             restrictions: info["restrictions"],
                             body: File.read(File.dirname(task) + "/task.md"))

      Dir.glob(File.dirname(task) + "/tests/*.in").sort { |name| name.split("/").last.split(".").first.to_i } .each do |file|
        id = file.split("/").last.split(".").first

        test = task_obj.test_cases.build
        test.input = File.read(file)
        test.output = File.read(File.dirname(file) + "/" + id + ".out")
        test.save!
      end
    end
  end
end
