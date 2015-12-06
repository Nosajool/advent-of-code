# --- Day 6: Probably a Fire Hazard ---

# Because your neighbors keep defeating you in the holiday house decorating contest year after year, you've decided to deploy one million lights in a 1000x1000 grid.

# Furthermore, because you've been especially nice this year, Santa has mailed you instructions on how to display the ideal lighting configuration.

# Lights in your grid are numbered from 0 to 999 in each direction; the lights at each corner are at 0,0, 0,999, 999,999, and 999,0. The instructions include whether to turn on, turn off, or toggle various inclusive ranges given as coordinate pairs. Each coordinate pair represents opposite corners of a rectangle, inclusive; a coordinate pair like 0,0 through 2,2 therefore refers to 9 lights in a 3x3 square. The lights all start turned off.

# To defeat your neighbors this year, all you have to do is set up your lights by doing the instructions Santa sent you in order.

# For example:

# turn on 0,0 through 999,999 would turn on (or leave on) every light.
# toggle 0,0 through 999,0 would toggle the first line of 1000 lights, turning off the ones that were on, and turning on the ones that were off.
# turn off 499,499 through 500,500 would turn off (or leave off) the middle four lights.
# After following the instructions, how many lights are lit?

module Advent
  class Day6

    def initialize
      @instructions = File.readlines(File.dirname(__FILE__) + "/input.txt")

    end

    def problem1
      light_bulbs = Array.new(1000) { Array.new(1000) { Lightbulb.new } }
      @instructions.each do |instruction|
        coordinates = instruction.split(" ").map { |word| word if word =~ /,/ }
        coordinates.compact!
        xcoords = coordinates.map { |coord| coord.split(",").first.to_i }
        ycoords = coordinates.map { |coord| coord.split(",").last.to_i }
        (xcoords.first..xcoords.last).each do |x|
          (ycoords.first..ycoords.last).each do |y|
            light_bulbs[x][y].turn_on if instruction.include? 'on'
            light_bulbs[x][y].turn_off if instruction.include? 'off'
            light_bulbs[x][y].toggle if instruction.include? 'toggle'
          end
        end

      end
      
      light_bulbs.inject(0) { |sum, x| sum += x.count(&:on?) }
    end

  end

  class Lightbulb

    def initialize
      @state = 0
    end

    def toggle
      @state = 1 - @state
    end

    def turn_on
      @state = 1
    end

    def turn_off
      @state = 0
    end

    def on?
      @state == 1
    end

  end
end
