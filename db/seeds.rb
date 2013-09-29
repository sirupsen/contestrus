sirup = User.create(username: "sirup", password: "seekrit")

competition = Competition.create(name: "Simon's Competition")

hello_world_task_desc = <<-EOF
Start your journey with a simple task. Print "Hello World" to stdout.

### Input

This task features no input.

### Output

Print "Hello World" to stdout. 
EOF
task = Task.create name: "Hello World", competition: competition, body: hello_world_task_desc

task.test_cases.create(input: "", output: "Hello World")
task.test_cases.create(input: "", output: "Hello World")
