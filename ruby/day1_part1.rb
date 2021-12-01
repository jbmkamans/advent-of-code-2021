depths = IO.readlines('../input/day1_part1.txt').map(&:to_i)
p depths

depth_diffs = []

depths.each_with_index do |depth, index|
  next if index.zero?

  depth_diffs << (depth > depths[index - 1] ? 1 : 0)
end

p depth_diffs.reduce(&:+)
