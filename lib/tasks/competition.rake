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

      unless info["groups"]
        info["groups"] = { "1" => 100 }
      end

      info["groups"].each do |name, points|
        task_obj.groups.create(name: name, points: points)
      end

      groups = task_obj.reload.groups
      task_obj.reload.groups.each do |group|
        test_dir = groups.count == 1 ? "" : "#{group.name}/"
        Dir.glob(File.dirname(task) + "/tests/#{test_dir}*.in").sort { |name| name.split("/").last.split(".").first.to_i } .each do |file|
          id = file.split("/").last.split(".").first

          test = task_obj.test_cases.build
          test.input = File.read(file)
          test.group_id = group.id
          test.output = File.read(File.dirname(file) + "/" + id + ".out")
          test.save!
        end
      end
    end
  end
end
