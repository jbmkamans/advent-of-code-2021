# frozen_string_literal: true

require '../utils/aoc_input_file'
inputfile = AOCInputFile.path(__FILE__)

depths = File.readlines(inputfile)

n = 0
aim = 0
horizontal_position = 0
depth = 0
instructions = { 'forward' => 0, 'up' => 0, 'down' => 0 }
while n < depths.length
  instruction, value = depths[n].split
  value = value.to_i

  case instruction
  when 'up'
    aim -= value
  when 'down'
    aim += value
  when 'forward'
    depth += aim * value
    horizontal_position += value
  end

  n += 1
end
p depth * horizontal_position
