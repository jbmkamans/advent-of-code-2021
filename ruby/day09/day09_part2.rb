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
        low_points << [row_index, clmn_index] if smaller_then_down && smaller_then_right
      elsif clmn_index == (COLUMNS - 1) # dont check right
        low_points << [row_index, clmn_index] if smaller_then_down && smaller_then_left
      elsif smaller_then_down && smaller_then_right && smaller_then_left
        low_points << [row_index, clmn_index]

      end
    elsif row_index == (ROWS - 1) # dont check down
      if clmn_index.zero? # dont check left
        low_points << [row_index, clmn_index] if smaller_then_up && smaller_then_right
      elsif clmn_index == (COLUMNS - 1) # dont check right
        low_points << [row_index, clmn_index] if smaller_then_up && smaller_then_left
      elsif smaller_then_up && smaller_then_right && smaller_then_left
        low_points << [row_index, clmn_index]

      end
    elsif clmn_index.zero?
      # row in middle
      low_points << [row_index, clmn_index] if smaller_then_up && smaller_then_down && smaller_then_right
    elsif clmn_index == (COLUMNS - 1) # dont check right
      low_points << [row_index, clmn_index] if smaller_then_up && smaller_then_down && smaller_then_left
    elsif smaller_then_up && smaller_then_down && smaller_then_right && smaller_then_left
      low_points << [row_index, clmn_index]

    end
  end
end

low_points.each.with_index do |low_point, low_point_index|
  basins = []
  points_to_check = [low_point] # queue

  while points_to_check.any?
    # points_to_check.each_with_index do |point, index|
    # points_to_check.delete_at(index)
    point = points_to_check.shift
    basins << point

    row_index = point[0]
    clmn_index = point[1]
    point = big_array[row_index][clmn_index]

    next if point == 8

    if row_index.positive? && (point < big_array[row_index - 1][clmn_index] && big_array[row_index - 1][clmn_index] != 9)
      points_to_check << [row_index - 1,
                          clmn_index]
    end

    if row_index < (ROWS - 1) && (point < big_array[row_index + 1][clmn_index] && big_array[row_index + 1][clmn_index] != 9)
      points_to_check << [row_index + 1,
                          clmn_index]
    end

    if clmn_index.positive? && (point < big_array[row_index][clmn_index - 1] && big_array[row_index][clmn_index - 1] != 9)
      points_to_check << [row_index,
                          clmn_index - 1]
    end

    next unless clmn_index < (COLUMNS - 1)

    #  check right
    if point < big_array[row_index][clmn_index + 1] && big_array[row_index][clmn_index + 1] != 9
      points_to_check << [row_index,
                          clmn_index + 1]
    end

  end

  low_points[low_point_index] = basins
end
p low_points

low_points.map! do |basin|
  basin.uniq.sort.count
end

p low_points.sort.reverse[0..2]
p low_points.sort.reverse[0..2].reduce(&:*)
