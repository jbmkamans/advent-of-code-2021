# frozen_string_literal: true

require '../utils/aoc_input_file'
inputfile = AOCInputFile.path(__FILE__, testfile: false)

output_numbers = File.readlines(inputfile, chomp: true)
                     .map { |line| line.split('|') }
                     .map do |scrambled, output|
                       output = output.split.sort_by(&:length).map { |s| s.chars.sort.join }
                       scrambled = scrambled.split.sort_by(&:length).map { |s| s.chars.sort.join }
                       p scrambled, output

                       hash = {}
                       hash[1] = scrambled[0]
                       hash[7] = scrambled[1]
                       hash[4] = scrambled[2]
                       hash[8] = scrambled[9]

                       scrambled.each do |scramble|
                         if !hash.value?(scramble) && (scramble.chars | hash[1].chars).sort == hash[8].chars
                           hash[6] =
                             scramble
                         end
                       end

                       scrambled.each do |scramble|
                         if !hash.value?(scramble) && (scramble.chars | hash[6].chars).sort == hash[6].chars
                           hash[5] =
                             scramble
                         end
                       end

                       scrambled.each do |scramble|
                         if !hash.value?(scramble) && scramble.chars == (hash[1].chars | hash[5].chars).sort
                           hash[9] =
                             scramble
                         end
                       end

                       scrambled.each do |scramble|
                         if !hash.value?(scramble) && (scramble.chars | hash[4].chars).sort == hash[9].chars
                           hash[3] =
                             scramble
                         end
                       end

                       scrambled.each do |scramble|
                         if !hash.value?(scramble) && (scramble.chars | hash[3].chars).sort == hash[8].chars
                           hash[0] =
                             scramble
                         end
                       end

                       scrambled.each do |scramble|
                         hash[2] = scramble unless hash.value?(scramble)
                       end

                       output.map { |s| hash.key(s) }
                     end

p output_numbers.flatten.sort.count { |nr| [1, 4, 7, 8].include?(nr) }
