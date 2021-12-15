# frozen_string_literal: true

require '../utils/aoc_input_file'

testfile = false
inputfile = AOCInputFile.path(__FILE__, testfile: testfile)
if testfile
  ROWS = 5
  COLUMNS = 10
else
  ROWS = 100
  COLUMNS = 100
end

big_array = Array.new(ROWS) { Array.new(COLUMNS) { 0 } }

File.readlines(inputfile, chomp: true).map.with_index do |line, index|
  big_array[index] = line.chars.map(&:to_i)
end
# p big_array

low_points = []
big_array.each.with_index do |row, row_index|
  row.each.with_index do |cell, clmn_index|
    smaller_then_left = false
    smaller_then_right = false
    smaller_then_up = false
    smaller_then_down = false

    if row_index.positive? && (cell < big_array[row_index - 1][clmn_index])
      # check above
      smaller_then_up = true
    end

    if row_index < (ROWS - 1) && (cell < big_array[row_index + 1][clmn_index])
      #  check below
      smaller_then_down = true
    end

    if clmn_index.positive? && (cell < big_array[row_index][clmn_index - 1])
      #  check left
      smaller_then_left = true
    end

    if clmn_index < (COLUMNS - 1) && (cell < big_array[row_index][clmn_index + 1])
      #  check right
      smaller_then_right = true
    end

    if row_index.zero? # dont check up
      if clmn_index.zero? # dont check left
        low_points << cell if smaller_then_down && smaller_then_right
      elsif clmn_index == (COLUMNS - 1) # dont check right
        low_points << cell if smaller_then_down && smaller_then_left
      elsif smaller_then_down && smaller_then_right && smaller_then_left
        low_points << cell
      end
    elsif row_index == (ROWS - 1) # dont check down
      if clmn_index.zero? # dont check left
        low_points << cell if smaller_then_up && smaller_then_right
      elsif clmn_index == (COLUMNS - 1) # dont check right
        low_points << cell if smaller_then_up && smaller_then_left
      elsif smaller_then_up && smaller_then_right && smaller_then_left
        low_points << cell
      end
    elsif clmn_index.zero?
      # row in middle
      low_points << cell if smaller_then_up && smaller_then_down && smaller_then_right
    elsif clmn_index == (COLUMNS - 1) # dont check right
      low_points << cell if smaller_then_up && smaller_then_down && smaller_then_left
    elsif smaller_then_up && smaller_then_down && smaller_then_right && smaller_then_left
      low_points << cell
    end
  end
end
p low_points
p low_points.map { |nr| nr + 1 }.sum
