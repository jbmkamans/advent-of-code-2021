require '../utils/aoc_input_file'
inputfile = AOCInputFile.path(__FILE__)

depths = File.readlines(inputfile).map(&:to_i)
p depths

depth_diffs = []
n = 0

while n < depths.length - 3
  depth_diffs << 1 if depths[n] < depths[n + 3]
  n += 1
end

p depth_diffs.reduce(&:+)
