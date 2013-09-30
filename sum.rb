puts $stdin.gets.strip.split(" ").map(&:to_i).reduce(:+)
