# frozen_string_literal: true

# Helper class for Advent of Code input files
class AOCInputFile
  # http://www.railstips.org/blog/archives/2006/11/18/class-and-instance-variables-in-ruby/
  class << self
    attr_accessor :inputs_directory
  end

  @inputs_directory = '../input'

  ##
  # Get path of input file belonging to the given ruby file.
  #
  # It tries to return one of these filepaths (in order of priority):
  #   input/dayXX_partY.txt
  #   input/dayXX.txt
  #   input/dayXX_partY_test.txt
  #   input/dayXX_test.txt
  #
  # If @param testfile = true, then the test file path will be returned.
  #
  # @param ruby_file [String] path to ruby file, file should follow the naming convention /day\d{2}(_part[12])?/
  # @param test [Boolean] if true, show test file
  #
  # @return the path to the input file.
  #
  # @example Valid values of @param ruby_file:
  #   day01.rb
  #   day01_part1.rb
  # @example Valid return values are:
  #   input/day01.txt
  #   input/day01_part1.txt
  #   input/day01_part1_test.txt
  #   input/day01_test.txt
  def self.path(ruby_file, testfile: false)
    day, part = File.basename(ruby_file).split(/[_.]/)

    return path_to_testfile(day, part) if testfile

    part_inputfile = "#{File.join(@inputs_directory, "#{day}_#{part}")}.txt"
    return part_inputfile if File.exist?(part_inputfile)

    inputfile = "#{File.join(@inputs_directory, day)}.txt"
    return inputfile if File.exist?(inputfile)

    path_to_testfile(day, part)
  end

  def self.path_to_testfile(day, part)
    test_part_inputfile = "#{File.join(@inputs_directory, "#{day}_#{part}_test")}.txt"
    return test_part_inputfile if File.exist?(test_part_inputfile)

    test_inputfile = "#{File.join(@inputs_directory, "#{day}_test")}.txt"
    return test_inputfile if File.exist?(test_inputfile)

    raise "No test file found for day #{day}"
  end
end
