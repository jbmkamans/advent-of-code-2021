# frozen_string_literal: true

require '../utils/bit_utils'
require '../utils/aoc_input_file'
inputfile = AOCInputFile.path(__FILE__, testfile: false)

# @param sorted_list [Array<String>] list of bitstrings of equal length, sorted ascending
# @param most_common [Boolean]
# @return [Array<String>] list of bits , where each index contains the bit that is most/least common on that index in
# the original list
def common_bits(sorted_list, most_common)
  return sorted_list if sorted_list.size == 1

  # get index of first bitstring that starts with bit 1
  index_of_one = sorted_list.bsearch_index { |bitstring| bitstring.start_with?('1') }

  if index_of_one.nil? # no bitstring starts with a '1'
    bitstrings_starting_with_zero = sorted_list
    bitstrings_starting_with_one = []
  elsif index_of_one.zero? # no bitstring starts with a '0'
    bitstrings_starting_with_zero = []
    bitstrings_starting_with_one = sorted_list
  else # there are bitstrings that start with a '0' and that start with a '1'
    bitstrings_starting_with_zero = sorted_list[0..index_of_one - 1]
    bitstrings_starting_with_one = sorted_list[index_of_one..]
  end

  if most_common
    if !bitstrings_starting_with_one.empty? && bitstrings_starting_with_one.size >= bitstrings_starting_with_zero.size
      [1] + common_bits(bitstrings_starting_with_one.map { |bitstring| bitstring[1..] }, most_common)
    else
      [0] + common_bits(bitstrings_starting_with_zero.map { |bitstring| bitstring[1..] }, most_common)
    end
  elsif !bitstrings_starting_with_zero.empty? && bitstrings_starting_with_zero.size <= bitstrings_starting_with_one.size
    [0] + common_bits(bitstrings_starting_with_zero.map { |bitstring| bitstring[1..] }, most_common)
  else
    [1] + common_bits(bitstrings_starting_with_one.map { |bitstring| bitstring[1..] }, most_common)
  end
end

bits = File.readlines(inputfile, chomp: true).map(&:chars).map(&:join)
bits.sort!

oxygen_rating = common_bits(bits, true)
co2_rating = common_bits(bits, false)

puts "oxygen_rating = #{oxygen_rating} = #{oxygen_rating.join} = #{oxygen_rating.join.to_i(2)}"
puts "co2_rating = #{co2_rating} = #{co2_rating.join} = #{co2_rating.join.to_i(2)}"
p oxygen_rating.join.to_i(2) * co2_rating.join.to_i(2)
