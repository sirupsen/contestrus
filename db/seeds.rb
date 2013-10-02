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


mega_inversions = punchball.tasks.create do |task|
  task.name = "Mega Inversions"
  task.body = <<-EOF
The `$n^2$` upper bound for any sorting algorithm is easy to obtain: just take two
elements that are misplaced with respect to each other and swap them.  Conrad
conceived an algorithm that proceeds by taking not two, but three misplaced
elements.  That is, take three elements `$a_i > b_j > a_k$` with `$i < j < k$` and
place them in order `$a_k, a_j, a_i$`. Now if for the original algorithm the steps
are bounded by the maximum number of inversions `$n(n − 1) \\over 2$` , Conrad is at his
wits’ end as 2 to the upper bound for such triples in a given sequence. He
asks you to write a program that counts the number of such triples.

### Input
The first line of the input is the length of the sequence, `$1 \\le n \\le 10^5$`. The next
line contains the integer sequence `$a_1, a_2, \\ldots a_n$`.  You can assume that all
`$a_i \\in \\left[1, n\\right]$`.

### Output
Output the number of inverted triples.

### Sample input

First sample input:

    3
    1 2 3
    # => 0

Second sample input:

    4
    3 3 2 1
    # => 2

Source: [Nordic Collegiate Programming Competition 2011.](https://ncpc.idi.ntnu.no/ncpc2011/ncpc2011problems.pdf)
  EOF
end

task_path = "sample/mega_inversions/"
Dir.glob("./sample/mega_inversions/*.in") do |file|
  id = file.split("/").last.split(".").first
  test = mega_inversions.test_cases.build
  test.input = File.read(file)
  test.output = File.read(task_path + id + ".out")
  test.save
end
