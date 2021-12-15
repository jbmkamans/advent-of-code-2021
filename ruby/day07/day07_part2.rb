# frozen_string_literal: true

require '../utils/aoc_input_file'
inputfile = AOCInputFile.path(__FILE__, testfile: false)

list = File.readlines(inputfile, chomp: true).first.split(',').map(&:to_i)
max = list.max

hash = {}

# this code takes 2 minutes to complete... but it works :)
(1..max).each do |target|
  hash[target] = list.map { |pos| (1..(pos - target).abs).inject(:+) || 1 }.sum
end

# p hash.sort_by { |_pos, fuel| fuel }
p hash.min_by { |_pos, fuel| fuel }
