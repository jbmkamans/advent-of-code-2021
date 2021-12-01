depths = IO.readlines('../input/day1_part2.txt').map(&:to_i)
p depths

depth_diffs = []
n = 0

while n < depths.length - 3
  depth_diffs << 1 if depths[n] < depths[n + 3]
  n += 1
end

p depth_diffs.reduce(&:+)
