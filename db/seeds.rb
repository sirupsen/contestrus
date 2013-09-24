sirup = User.create(username: "sirup", password: "seekrit")

competition = Competition.create(name: "Simon's Competition")
task = Task.create(name: "Hello World", competition: competition, body: "Print 'Hello World'")
task.test_cases.create(input: "", output: "Hello World")
task.test_cases.create(input: "", output: "Hello World")
