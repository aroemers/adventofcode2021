# frozen_string_literal: true

require 'set'

### Read and parse input

def read_input(filename)
  lines = File.readlines(filename, chomp: true)

  algorithm = lines[0].gsub(/./, { '#' => '1', '.' => '0' }).chars

  image = Set[]
  lines.drop(2).each_with_index do |line, y|
    line.chars.each_with_index do |char, x|
      image << [y, x] if char == '#'
    end
  end

  [algorithm, image]
end

### Part 1

def square(pixel)
  y, x = pixel
  [
    [y - 1, x - 1],
    [y - 1, x],
    [y - 1, x + 1],
    [y, x - 1],
    [y, x],
    [y, x + 1],
    [y + 1, x - 1],
    [y + 1, x],
    [y + 1, x + 1]
  ]
end

def process(algorithm, image, background)
  foreground = background == '0' ? '1' : '0'
  new_background = background == '0' ? algorithm.first : algorithm.last
  output = Set[]
  image.each do |pixel|
    square(pixel).each do |process|
      index = square(process).collect do |neighbour|
        image.include?(neighbour) ? foreground : background
      end.join.to_i(2)
      output << process if algorithm[index] != new_background
    end
  end

  [output, new_background]
end

def solve1(filename)
  algorithm, image = read_input filename
  background = '0'

  2.times { image, background = process(algorithm, image, background) }

  image.size
end

### Part 2

def solve2(filename)
  algorithm, image = read_input filename
  background = '0'

  50.times { image, background = process(algorithm, image, background) }

  image.size
end
