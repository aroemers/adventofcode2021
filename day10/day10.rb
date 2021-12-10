# frozen_string_literal: true

### Read and parse input

def read_input(filename)
  File.readlines(filename, chomp: true).collect(&:chars)
end

### Part 1

OPEN =  '({[<'.chars.freeze
CLOSE = ')}]>'.chars.freeze
POINTS1 = {
  ')' => 3,
  ']' => 57,
  '}' => 1197,
  '>' => 25_137
}.freeze

def process(line)
  stack = []

  until line.empty?
    char = line.first
    if (index = OPEN.find_index char)
      stack.unshift CLOSE[index]
    else
      expected = stack.first
      return [stack, line] unless char == expected

      stack.shift
    end
    line.shift
  end

  [stack, line]
end

def solve1(filename)
  lines = read_input filename
  processed = lines.collect { |line| process line }
  corrupted = processed.reject { |_stack, leftover| leftover.empty? }
  illegals = corrupted.collect { |_stack, leftover| leftover.first }
  illegals.inject(0) { |sum, illegal| sum + POINTS1[illegal] }
end

### Part 2

POINTS2 = {
  ')' => 1,
  ']' => 2,
  '}' => 3,
  '>' => 4
}.freeze

def solve2(filename)
  lines = read_input filename
  processed = lines.collect { |line| process line }
  incompletes = processed.select { |_stack, leftover| leftover.empty? }
  scores = incompletes.collect do |stack, _leftover|
    stack.inject(0) { |score, char| score * 5 + POINTS2[char] }
  end
  scores.sort[scores.size / 2]
end
