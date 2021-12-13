# frozen_string_literal: true

### Read and parse input

def read_input(filename)
  dots = []
  instructions = []

  File.readlines(filename, chomp: true).each do |line|
    if (match = line.match(/(\d+),(\d+)/))
      dots << [match[1].to_i, match[2].to_i]
    elsif (match = line.match(/fold along (\w)=(\d+)/))
      instructions << [match[1], match[2].to_i]
    end
  end

  [dots, instructions]
end

### Part 1

def fold(dots, instruction)
  fold, at = instruction
  dots.collect do |x, y|
    case fold
    when 'y'
      [x, at - (y - at).abs]
    when 'x'
      [at - (x - at).abs, y]
    end
  end.uniq
end

def solve1(filename)
  dots, instructions = read_input filename
  fold(dots, instructions[0]).size
end

### Part 2

def visualize(dots)
  max_x, max_y = dots.inject { |acc, dot| acc.zip(dot).collect(&:max) }

  0.upto(max_y).collect do |y|
    0.upto(max_x).collect do |x|
      dots.include?([x, y]) ? '#' : '.'
    end.join
  end.join("\n")
end

def solve2(filename)
  dots, instructions = read_input filename
  folded = instructions.inject(dots) { |acc, instruction| fold acc, instruction }
  visualize folded
end
