# --- Day 5: Doesn't He Have Intern-Elves For This? ---

# Santa needs help figuring out which strings in his text file are naughty or nice.

# A nice string is one with all of the following properties:

# It contains at least three vowels (aeiou only), like aei, xazegov, or aeiouaeiouaeiou.
# It contains at least one letter that appears twice in a row, like xx, abcdde (dd), or aabbccdd (aa, bb, cc, or dd).
# It does not contain the strings ab, cd, pq, or xy, even if they are part of one of the other requirements.
# For example:

# ugknbfddgicrmopn is nice because it has at least three vowels (u...i...o...), a double letter (...dd...), and none of the disallowed substrings.
# aaa is nice because it has at least three vowels and a double letter, even though the letters used by different rules overlap.
# jchzalrnumimnmhp is naughty because it has no double letter.
# haegwjzuvuyypxyu is naughty because it contains the string xy.
# dvszwmarrgswjxmb is naughty because it contains only one vowel.
# How many strings are nice?

module Advent
  class Day5

    def initialize
      @words = File.readlines(File.dirname(__FILE__) + "/input.txt").map { |word| word.chomp }
    end

    def problem1
      nice_word_count = 0
      @words.each do |word|
        next if word.scan(/[aeiou]/).count < 3
        next if /(.)\1/ !~ word
        next if /ab|cd|pq|xy/ =~ word

        nice_word_count += 1
      end

      nice_word_count
    end
  end
end
