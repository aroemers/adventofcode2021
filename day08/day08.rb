# frozen_string_literal: true

### Reading and parsing input

def read_input(filename)
  lines = []

  File.readlines(filename, chomp: true).each do |line|
    signal_part, output_part = line.split('|')
    signals = signal_part.split(' ').collect(&:strip)
    outputs = output_part.split(' ').collect(&:strip)
    lines << { signals: signals, outputs: outputs }
  end

  lines
end

### Part 1

UNIQUE_COUNTS = [2, 3, 4, 7].freeze

def solve1(filename)
  read_input(filename).inject(0) do |acc, line|
    acc + line[:outputs].count do |output|
      UNIQUE_COUNTS.include? output.size
    end
  end
end

### Part 2

class String
  def overlap(other)
    chars.intersection(other.chars).size
  end

  def sort
    chars.sort.join
  end
end

def encoding(signals)
  one = signals.find { |signal| signal.size == 2 }
  seven = signals.find { |signal| signal.size == 3 }
  four = signals.find { |signal| signal.size == 4 }
  eight = signals.find { |signal| signal.size == 7 }

  two = signals.find { |signal| signal.size == 5 and signal.overlap(four) == 2 }
  three = signals.find { |signal| signal.size == 5 and signal.overlap(one) == 2 }
  five = signals.find { |signal| signal.size == 5 and signal.overlap(four) == 3 and signal.overlap(one) == 1 }

  six = signals.find { |signal| signal.size == 6 and signal.overlap(one) == 1 }
  nine = signals.find { |signal| signal.size == 6 and signal.overlap(four) == 4 }
  zero = signals.find { |signal| signal.size == 6 and signal.overlap(four) == 3 and signal.overlap(one) == 2 }

  [zero, one, two, three, four, five, six, seven, eight, nine].collect(&:sort)
end

def solve2(filename)
  lines = read_input(filename)
  lines.inject(0) do |sum, line|
    codes = encoding line[:signals]
    sum + line[:outputs].collect do |output|
      codes.find_index output.sort
    end.join.to_i
  end
end
