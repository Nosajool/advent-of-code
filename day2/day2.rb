# --- Day 2: I Was Told There Would Be No Math ---

# The elves are running low on wrapping paper, and so they need to submit an order for more. They have a list of the dimensions (length l, width w, and height h) of each present, and only want to order exactly as much as they need.

# Fortunately, every present is a box (a perfect right rectangular prism), which makes calculating the required wrapping paper for each gift a little easier: find the surface area of the box, which is 2*l*w + 2*w*h + 2*h*l. The elves also need a little extra paper for each present: the area of the smallest side.

# For example:

# A present with dimensions 2x3x4 requires 2*6 + 2*12 + 2*8 = 52 square feet of wrapping paper plus 6 square feet of slack, for a total of 58 square feet.
# A present with dimensions 1x1x10 requires 2*1 + 2*10 + 2*10 = 42 square feet of wrapping paper plus 1 square foot of slack, for a total of 43 square feet.
# All numbers in the elves' list are in feet. How many total square feet of wrapping paper should they order?

module Advent
  class Day2

    def initialize
      @file = File.open(File.dirname(__FILE__) + "/input.txt", "r")
    end

    def problem1
      total_wrapping_paper = 0
      while line = @file.gets
        dimensions = line.split("x")
        total_wrapping_paper += wrapping_paper_surface_area(dimensions)
      end

      total_wrapping_paper
    end

    private

    def wrapping_paper_surface_area(dimensions)
      surface_area_of_sides = dimensions.combination(2).to_a.map { |x, y| x.to_i * y.to_i }
      2 * surface_area_of_sides.inject(:+) + surface_area_of_sides.min
    end
  end
end
