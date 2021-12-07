# frozen_string_literal: true

require '../utils/aoc_input_file'
inputfile = AOCInputFile.path(__FILE__)

submarine_stats = File.readlines(inputfile)
                      .map(&:split)
                      .each_with_object({ 'aim' => 0, 'depth' => 0, 'pos' => 0 }) do |line, obj|
                        value = line[1].to_i

                        case line[0]
                        when 'up'
                          obj['aim'] -= value
                        when 'down'
                          obj['aim'] += value
                        when 'forward'
                          obj['depth'] += obj['aim'] * value
                          obj['pos'] += value
                        else
                          raise "Invalid instruction: #{line[0]}"
                        end
                      end

p submarine_stats
p submarine_stats['depth'] * submarine_stats['pos']
