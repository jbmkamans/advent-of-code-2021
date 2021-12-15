# frozen_string_literal: true

# Class for BingoBoard
class BingoBoard
  attr_accessor :board

  # @param board [Array<Array<Integer>>]
  def initialize(board)
    # @type [Array<Array<Integer>>]
    @board = board
  end

  # @return [BingoBoard, Boolean] board if it has won, false otherwise
  def mark_number(number)
    if @board.map.with_index do |row, row_index|
      if row.include?(number)
        column_index = row.find_index(number)
        row[column_index] = nil # set found numbers to nil
        row_done(row_index) || column_done(column_index)
      else
        false
      end
    end.any?
      self
    end
  end

  def row_done(index)
    @board[index].all?(nil)
  end

  def column_done(index)
    @board.map { |row| row[index] }.all?(nil)
  end

  def sum_of_unmarked_numbers
    @board.map { |row| row.reduce(0) { |total, number| total + (number.nil? ? 0 : number) } }.sum
  end
end
