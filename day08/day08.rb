# frozen_string_literal: true

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

UNIQUE_COUNTS = [2, 3, 4, 7].freeze

def solve1(filename)
  read_input(filename).inject(0) do |acc, line|
    acc + line[:outputs].count do |output|
      UNIQUE_COUNTS.include? output.size
    end
  end
end

def intersects(signal, chars, expected_count)
  signal.chars.intersection(chars).size == expected_count
end

def encoding(signals)
  one = signals.find { |signal| signal.size == 2 }.chars
  seven = signals.find { |signal| signal.size == 3 }.chars
  four = signals.find { |signal| signal.size == 4 }.chars
  eight = signals.find { |signal| signal.size == 7 }.chars

  two = signals.find { |signal| signal.size == 5 && intersects(signal, four, 2) }.chars
  three = signals.find { |signal| signal.size == 5 && intersects(signal, one, 2) }.chars
  five = signals.find { |signal| signal.size == 5 && intersects(signal, four, 3) && intersects(signal, one, 1) }.chars

  six = signals.find { |signal| signal.size == 6 && intersects(signal, one, 1) }.chars
  nine = signals.find { |signal| signal.size == 6 && intersects(signal, four, 4) }.chars
  zero = signals.find { |signal| signal.size == 6 && intersects(signal, four, 3) && intersects(signal, one, 2) }.chars
  [zero, one, two, three, four, five, six, seven, eight, nine].collect(&:sort)
end

def solve2(filename)
  lines = read_input(filename)
  lines.inject(0) do |sum, line|
    codes = encoding line[:signals]
    sum + line[:outputs].collect do |output|
      codes.find_index output.chars.sort
    end.join.to_i
  end
end
