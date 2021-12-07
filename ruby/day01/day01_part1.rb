# frozen_string_literal: true

require '../utils/aoc_input_file'
inputfile = AOCInputFile.path(__FILE__)

depths = File.readlines(inputfile).map(&:to_i)
p depths

# map each two consecutive numbers to true if the second number is greater than the first number,
# then count the number of true's.
ans = depths.each_cons(2).map { |first, second| second > first }.count(true)
puts "\nThe answer is: #{ans}"
