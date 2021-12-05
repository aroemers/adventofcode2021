# frozen_string_literal: true

# Represents a line segment
class Line
  def initialize(x1, y1, x2, y2)
    @x1, @y1, @x2, @y2 = [x1, y1, x2, y2]
  end

  # Returns true when this line is orthogonal, false otherwise.
  def orthogonal?
    @x1 == @x2 || @y1 == @y2
  end

  # Returns true when this line is horizontal, false otherwise.
  def horizontal?
    @y1 == @y2
  end

  # Returns an array of the [x,y] points this line covers.
  def points
    if orthogonal?
      if horizontal?
        x_min, x_max = [@x1, @x2].minmax
        x_range = (x_min..x_max)
        x_range.collect { |x| [x, @y1] }
      else
        y_min, y_max = [@y1, @y2].minmax
        y_range = (y_min..y_max)
        y_range.collect { |y| [@x1, y] }
      end
    else
      # The line is diagonal.
      x_range = @x1 < @x2 ? @x1.upto(@x2) : @x1.downto(@x2)
      y_range = @y1 < @y2 ? @y1.upto(@y2) : @y1.downto(@y2)
      x_range.zip y_range
    end
  end
end

def read_input(filename)
  input_lines = File.readlines(filename, chomp: true)
  input_lines.collect do |input_line|
    match = input_line.match(/(?<x1>\d+),(?<y1>\d+) -> (?<x2>\d+),(?<y2>\d+)/)
    Line.new match[:x1].to_i, match[:y1].to_i, match[:x2].to_i, match[:y2].to_i
  end
end

def fill_diagram(lines)
  diagram = []

  lines.each do |line|
    line.points.each do |x, y|
      diagram[y] ||= []
      diagram[y][x] ||= 0
      diagram[y][x] = diagram[y][x] + 1
    end
  end

  diagram
end

def solve(filename, &filter_method)
  lines = read_input filename
  diagram = fill_diagram lines.filter(&filter_method)
  diagram.reduce(0) do |overlap, xs|
    next(overlap) if xs.nil?

    overlap + xs.count { |x| x && x > 1 }
  end
end

def solve1(filename)
  solve(filename, &:orthogonal?)
end

def solve2(filename)
  solve(filename, &:itself)
end
