require '../utils/aoc_input_file'
inputfile = AOCInputFile.path(__FILE__)

depths = File.readlines(inputfile).map(&:to_i)
p depths

# map each index to true if its successor is greater, false otherwise
depths.map!.with_index do |depth, index|
  # skip last index, that has no successor
  next if index >= depths.size - 1

  depth < depths[index + 1]
end

puts "\nThe answer is: #{depths.count(true)}"
