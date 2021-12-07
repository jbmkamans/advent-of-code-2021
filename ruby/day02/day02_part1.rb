# frozen_string_literal: true

require '../utils/aoc_input_file'
inputfile = AOCInputFile.path(__FILE__)

instruction_to_sum = File.readlines(inputfile)
                         .map(&:split)
                         .each_with_object({ 'forward' => 0, 'up' => 0, 'down' => 0 }) do |line, obj|
                           obj[line[0]] += line[1].to_i
                         end
p instruction_to_sum
p instruction_to_sum['forward'] * (instruction_to_sum['down'] - instruction_to_sum['up'])
