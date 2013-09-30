sirup = User.create(username: "sirup", password: "seekrit")

punchball = Competition.create(name: "Punch Ball")

sum = punchball.tasks.create do |task|
  task.name = "Sum"
  task.body = <<-EOF
Alice wants to impress Bob with her math skills, unfortunately she dropped out
of math to take up her passion of performance crocheting of trains. Help Alice by
creating the engine for a new revolutionary application she can use from under the
table when Bob gives her one of his evil math questions over candle dinner.

### Input
Two numbers, a and b, which will fit in signed 64 bit integers.

### Output
The sum of a and b.
  EOF
end

sum.test_cases.create do |t|
  t.input  = "1 2"
  t.output = "3"
end

sum.test_cases.create do |t|
  t.input  = "7 5"
  t.output = "12"
end
