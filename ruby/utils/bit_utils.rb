# frozen_string_literal: true

# Class with helper methods for working with bits
class BitUtils
  ##
  # Get bitwise complement of bitstring
  #
  # @param bitstring [String] string containing only '1' and '0'
  #
  # @return [String] string with each bit flipped
  def self.complement(bitstring)
    (bitstring.to_i(2) ^ ((2**bitstring.length) - 1)).to_s(2)
  end
end
