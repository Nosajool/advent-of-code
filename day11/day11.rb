# --- Day 11: Corporate Policy ---

# Santa's previous password expired, and he needs help choosing a new one.

# To help him remember his new password after the old one expires, Santa has devised a method of coming up with a password based on the previous one. Corporate policy dictates that passwords must be exactly eight lowercase letters (for security reasons), so he finds his new password by incrementing his old password string repeatedly until it is valid.

# Incrementing is just like counting with numbers: xx, xy, xz, ya, yb, and so on. Increase the rightmost letter one step; if it was z, it wraps around to a, and repeat with the next letter to the left until one doesn't wrap around.

# Unfortunately for Santa, a new Security-Elf recently started, and he has imposed some additional password requirements:

# Passwords must include one increasing straight of at least three letters, like abc, bcd, cde, and so on, up to xyz. They cannot skip letters; abd doesn't count.
# Passwords may not contain the letters i, o, or l, as these letters can be mistaken for other characters and are therefore confusing.
# Passwords must contain at least two different, non-overlapping pairs of letters, like aa, bb, or zz.
# For example:

# hijklmmn meets the first requirement (because it contains the straight hij) but fails the second requirement requirement (because it contains i and l).
# abbceffg meets the third requirement (because it repeats bb and ff) but fails the first requirement.
# abbcegjk fails the third requirement, because it only has one double letter (bb).
# The next password after abcdefgh is abcdffaa.
# The next password after ghijklmn is ghjaabcc, because you eventually skip all the passwords that start with ghi..., since i is not allowed.
# Given Santa's current password (your puzzle input), what should his next password be?

# Your puzzle input is vzbxkghb.
# --- Part Two ---

# Santa's password expired again. What's the next one?

# Your puzzle input is still vzbxkghb.

module Advent
  class Day11

    def initialize
      @input = File.open(File.dirname(__FILE__) + "/input.txt").readline.chomp
    end

    def problem1
      next_valid_password(@input)
    end

    def problem2
      first_password = next_valid_password(@input)
      next_valid_password(first_password.succ)
    end

    private

    def next_valid_password(password)
      until valid_password?(password) do
        password.succ! # Returns the successor to str.
      end
      
      password
    end

    def valid_password?(password)
      @regex_3_letters ||= /#{("a".."z").each_cons(3).map(&:join).join("|")}/
      return false unless password =~ @regex_3_letters
      return false if password =~ /i|o|l/
      return false unless password.scan(/(.)\1/).size > 1

      return true
    end

  end
end