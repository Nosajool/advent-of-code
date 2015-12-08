# --- Day 7: Some Assembly Required ---

# This year, Santa brought little Bobby Tables a set of wires and bitwise logic gates! Unfortunately, little Bobby is a little under the recommended age range, and he needs help assembling the circuit.

# Each wire has an identifier (some lowercase letters) and can carry a 16-bit signal (a number from 0 to 65535). A signal is provided to each wire by a gate, another wire, or some specific value. Each wire can only get a signal from one source, but can provide its signal to multiple destinations. A gate provides no signal until all of its inputs have a signal.

# The included instructions booklet describes how to connect the parts together: x AND y -> z means to connect wires x and y to an AND gate, and then connect its output to wire z.

# For example:

# 123 -> x means that the signal 123 is provided to wire x.
# x AND y -> z means that the bitwise AND of wire x and wire y is provided to wire z.
# p LSHIFT 2 -> q means that the value from wire p is left-shifted by 2 and then provided to wire q.
# NOT e -> f means that the bitwise complement of the value from wire e is provided to wire f.
# Other possible gates include OR (bitwise OR) and RSHIFT (right-shift). If, for some reason, you'd like to emulate the circuit instead, almost all programming languages (for example, C, JavaScript, or Python) provide operators for these gates.

# For example, here is a simple circuit:

# 123 -> x
# 456 -> y
# x AND y -> d
# x OR y -> e
# x LSHIFT 2 -> f
# y RSHIFT 2 -> g
# NOT x -> h
# NOT y -> i
# After it is run, these are the signals on the wires:

# d: 72
# e: 507
# f: 492
# g: 114
# h: 65412
# i: 65079
# x: 123
# y: 456
# In little Bobby's kit's instructions booklet (provided as your puzzle input), what signal is ultimately provided to wire a?
# --- Part Two ---

# Now, take the signal you got on wire a, override wire b to that signal, and reset the other wires (including wire a). What new signal is ultimately provided to wire a?

class String
  def numeric?
    return true if self =~ /\A\d+\Z/
  end
end  

module Advent
  class Day7
    
    def initialize
      @instructions = File.readlines(File.dirname(__FILE__) + "/input.txt")
    end

    def problem1
      circuit = Circuit.new
      @instructions.each do |instruction|
        circuit.add_instruction(instruction)
      end
      
      circuit.wire_signal('a')
    end

    def problem2
      circuit = Circuit.new
      @instructions.each do |instruction|
        circuit.add_instruction(instruction)
      end
      circuit.add_instruction("#{circuit.wire_signal('a')} -> b")
      circuit.purge_cache

      circuit.wire_signal('a')
    end
  end

  class Circuit
    def initialize
      @expressions = {}
      @cached = {}
    end

    def add_instruction(instruction)
      expression, dest = instruction.chomp.split(' -> ')
      @expressions[dest] = expression
    end

    def wire_signal(wire_identifier)
      evaluate_expression(@expressions[wire_identifier])
    end

    def purge_cache
      @cached = {}
    end

    private

    def evaluate_expression(expression)
      tokens = expression.split
      if expression.include? "AND"
        result = evaluate_operand(tokens.first) & evaluate_operand(tokens.last)
      elsif expression.include? "OR"
        result = evaluate_operand(tokens.first) | evaluate_operand(tokens.last)
      elsif expression.include? "LSHIFT"
        result = evaluate_operand(tokens.first) << evaluate_operand(tokens.last)
      elsif expression.include? "RSHIFT"
        result = evaluate_operand(tokens.first) >> evaluate_operand(tokens.last)
      elsif expression.include? "NOT"
        result = ~evaluate_operand(tokens.last)
      else
        result = evaluate_operand(tokens.first)
      end

      result < 0 ? result + 0x10000 : result
    end

    def evaluate_operand(operand)
      return operand.to_i if operand.numeric?

      if @cached[operand]
        value = @cached[operand]
      else
        value = evaluate_expression(@expressions[operand])
        @cached[operand] = value
      end

      value
    end
  end
end
