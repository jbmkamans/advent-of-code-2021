# frozen_string_literal: true

require '../utils/aoc_input_file'
inputfile = AOCInputFile.path(__FILE__)

depths = File.readlines(inputfile)

n = 0
instructions = { 'forward' => 0, 'up' => 0, 'down' => 0 }
while n < depths.length
  instruction, value = depths[n].split
  instructions[instruction] += value.to_i
  n += 1
end

p instructions['forward'] * (instructions['down'] - instructions['up'])
