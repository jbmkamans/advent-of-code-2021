# frozen_string_literal: true

require '../day04/bingo_board'
require '../utils/aoc_input_file'
inputfile = AOCInputFile.path(__FILE__, testfile: false)

numbers_called = File.open(inputfile).readline.split(',').map(&:to_i)
bingo_boards = File.readlines(inputfile, chomp: true)
                   .drop(1)
                   .map(&:split)
                   .each_slice(6)
                   .map do |six_lines|
                     BingoBoard.new(six_lines[1..].map { |line| line.map(&:to_i) })
                   end

bingo_boards_done = {}
numbers_called.each do |number_called|
  bingo_boards
    .map.with_index do |board, index|
      board_marked = board.mark_number(number_called) unless bingo_boards_done.include?(index)
      bingo_boards_done[index] = [board.sum_of_unmarked_numbers, number_called] unless board_marked.nil?
    end
end
p bingo_boards_done.to_a.last[1].reduce(&:*)
