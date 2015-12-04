# --- Day 3: Perfectly Spherical Houses in a Vacuum ---

# Santa is delivering presents to an infinite two-dimensional grid of houses.

# He begins by delivering a present to the house at his starting location, and then an elf at the North Pole calls him via radio and tells him where to move next. Moves are always exactly one house to the north (^), south (v), east (>), or west (<). After each move, he delivers another present to the house at his new location.

# However, the elf back at the north pole has had a little too much eggnog, and so his directions are a little off, and Santa ends up visiting some houses more than once. How many houses receive at least one present?

# For example:

# > delivers presents to 2 houses: one at the starting location, and one to the east.
# ^>v< delivers presents to 4 houses in a square, including twice to the house at his starting/ending location.
# ^v^v^v^v^v delivers a bunch of presents to some very lucky children at only 2 houses.

module Advent
  class Day3

    def initialize
      file = File.open(File.dirname(__FILE__) + "/input.txt", "r")
      @input = file.readline
    end

    def problem1
      moves = @input.split("")
      current_location = [0,0]
      visited = {current_location => 1}
      moves.each do |move|
        current_location = new_location(current_location, move)
        visited[current_location] = visited[current_location] ? (visited[current_location] + 1) : 1
      end
      visited.keys.count
    end

    private

    def new_location(current_location, move)
      case move
      when '^'
        return [current_location.first, current_location.last + 1]
      when 'v'
        return [current_location.first, current_location.last - 1]
      when '>'
        return [current_location.first + 1, current_location.last]
      when '<'
        return [current_location.first - 1, current_location.last]
      end
    end
  end
end
