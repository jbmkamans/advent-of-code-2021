# frozen_string_literal: true

require '../day04/bingo_board'
require '../utils/aoc_input_file'
inputfile = AOCInputFile.path(__FILE__)

numbers_called = File.open(inputfile).readline.split(',').map(&:to_i)
bingo_boards = File.readlines(inputfile, chomp: true)
                   .drop(1)
                   .map(&:split)
                   .each_slice(6)
                   .map do |six_lines|
                     BingoBoard.new(six_lines[1..].map { |line| line.map(&:to_i) })
                   end

numbers_called.each do |number_called|
  max_sum = bingo_boards
            .map { |board| board.mark_number(number_called) }
            .filter { |board| !board.nil? }
            .map(&:sum_of_unmarked_numbers)
            .max

  unless max_sum.nil?
    p "sum = #{max_sum} number = #{number_called} score = #{max_sum * number_called}"
    break
  end
end
