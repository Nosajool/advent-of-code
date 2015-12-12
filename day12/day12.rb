# --- Day 12: JSAbacusFramework.io ---

# Santa's Accounting-Elves need help balancing the books after a recent order. Unfortunately, their accounting software uses a peculiar storage format. That's where you come in.

# They have a JSON document which contains a variety of things: arrays ([1,2,3]), objects ({"a":1, "b":2}), numbers, and strings. Your first job is to simply find all of the numbers throughout the document and add them together.

# For example:

# [1,2,3] and {"a":2,"b":4} both have a sum of 6.
# [[[3]]] and {"a":{"b":4},"c":-1} both have a sum of 3.
# {"a":[-1,1]} and [-1,{"a":1}] both have a sum of 0.
# [] and {} both have a sum of 0.
# You will not encounter any strings containing numbers.

# What is the sum of all numbers in the document?
# --- Part Two ---

# Uh oh - the Accounting-Elves have realized that they double-counted everything red.

# Ignore any object (and all of its children) which has any property with the value "red". Do this only for objects ({...}), not arrays ([...]).

# [1,2,3] still has a sum of 6.
# [1,{"c":"red","b":2},3] now has a sum of 4, because the middle object is ignored.
# {"d":"red","e":[1,2,3,4],"f":5} now has a sum of 0, because the entire structure is ignored.
# [1,"red",5] has a sum of 6, because "red" in an array has no effect.

require 'json'

module Advent
  class Day12

    def initialize
      @input = File.open(File.dirname(__FILE__) + "/input.txt").readline.chomp
    end

    def problem1
      @input.scan(/(-?\d+)/).map { |num| num.first.to_i }.reduce(:+)
    end

    def problem2
      sum_avoiding_red(JSON.parse(@input))
    end

    private

    def sum_avoiding_red(input)
      if input.kind_of?(Array)
        return input.map { |element| sum_avoiding_red(element) }.reduce(:+)
      elsif input.kind_of?(Hash)
        return 0 if input.values.include?("red")
        return input.map { |value| sum_avoiding_red(value) }.reduce(:+)
      elsif input.kind_of?(Numeric)
        return input
      else
        return 0
      end
    end
  end
end
