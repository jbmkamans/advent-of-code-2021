# frozen_string_literal: true

require '../utils/bit_utils'
require '../utils/aoc_input_file'
inputfile = AOCInputFile.path(__FILE__)

bits = File.readlines(inputfile, chomp: true).map(&:chars)
bits_transposed = bits.transpose

gamma_rate = bits_transposed
             .map do |bits_array| # for each char-array
               bits_array
                 .tally # get hash with frequencies of each bit
                 .max_by { |_k, v| v } # get bit+frequency pair with highest frequency
                 .first # get bit
             end
             .join # join chars to get a string

# epsilon_rate is the bitwise complement of gamma_rate, so XOR it with "111.......1"
epsilon_rate = BitUtils.complement(gamma_rate)

puts "gamma_rate=#{gamma_rate}, epsilon_rate=#{epsilon_rate}, product=#{gamma_rate.to_i(2) * epsilon_rate.to_i(2)}"
