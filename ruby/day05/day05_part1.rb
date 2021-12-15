# frozen_string_literal: true

require '../utils/aoc_input_file'

testfile = false
inputfile = AOCInputFile.path(__FILE__, testfile: testfile)
big_array = if testfile
              Array.new(10) { Array.new(10) { 0 } }
            else
              Array.new(999) { Array.new(999) { 0 } }
            end

File.readlines(inputfile, chomp: true)
    .each do |line|
      line.scan(/(\d+),(\d+) -> (\d+),(\d+)/) do |x1, y1, x2, y2|
        next unless x1 == x2 || y1 == y2

        x_min, x_max = [x1.to_i, x2.to_i].minmax
        y_min, y_max = [y1.to_i, y2.to_i].minmax

        (x_min.to_i..x_max.to_i).each do |x|
          (y_min.to_i..y_max.to_i).each do |y|
            big_array[x][y] += 1
          end
        end
      end
    end

p big_array.sum { |row| row.count { |cell| cell > 1 } }
