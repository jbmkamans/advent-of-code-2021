# frozen_string_literal: true

require '../utils/aoc_input_file'
inputfile = AOCInputFile.path(__FILE__, testfile: true)

list = File.readlines(inputfile, chomp: true).first.split(',').map(&:to_i)
max = list.max

hash = {}

(1..max).each do |target|
  hash[target] = list.map { |pos| (pos - target).abs }.sum
end

p hash.min_by { |_pos, fuel| fuel }
