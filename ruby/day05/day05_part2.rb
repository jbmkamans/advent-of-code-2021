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
        x1 = x1.to_i
        x2 = x2.to_i
        y1 = y1.to_i
        y2 = y2.to_i

        y_values = if y1 < y2
                     (y1..y2).to_a
                   elsif y1 > y2
                     y1.downto(y2).to_a
                   else
                     Array.new((x1 - x2).abs + 1, y1)
                   end

        if x1 < x2
          x_values = (x1..x2).to_a
        elsif x1 > x2
          x_values = (x2..x1).to_a
          y_values.reverse!
        else
          x_values = Array.new(y_values.size, x1)
        end

        x_values.zip(y_values).each do |x, y|
          big_array[x][y] += 1
        end
      end
    end

p big_array.sum { |row| row.count { |cell| cell > 1 } }
