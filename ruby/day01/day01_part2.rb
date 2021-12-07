# frozen_string_literal: true

require '../utils/aoc_input_file'
inputfile = AOCInputFile.path(__FILE__)

depths = File.readlines(inputfile).map(&:to_i)
p depths

ans = depths.each_cons(4).map { |first, _, _, fourth| fourth > first }.count(true)
puts "\nThe answer is: #{ans}"
