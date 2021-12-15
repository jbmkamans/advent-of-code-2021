# frozen_string_literal: true

require '../utils/aoc_input_file'
inputfile = AOCInputFile.path(__FILE__, testfile: false)

list = File.readlines(inputfile, chomp: true).first.split(',').map(&:to_i)
list.sort!
list = list.tally

(0..8).each { |nr| list[nr] = 0 unless list.key?(nr) }

256.times do
  temp = list[0]
  (1..8).each { |nr| list[nr - 1] = list[nr] }
  list[8] = temp
  list[6] += temp
end

p list.values.sum
