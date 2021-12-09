# frozen_string_literal: true

### Read and parse input

def read_input(filename)
  File.readlines(filename, chomp: true).collect do |line|
    line.chars.collect(&:to_i)
  end
end

### Part 1

def around(grid, y, x)
  points = []

  points << [y - 1, x] unless y == 0
  points << [y + 1, x] unless y == grid.size - 1
  points << [y, x - 1] unless x == 0
  points << [y, x + 1] unless x == grid[0].size - 1

  points
end

def low_point?(grid, y, x)
  height = grid[y][x]
  around(grid, y, x).all? { |y, x| height < grid[y][x] }
end

def low_points(grid)
  points = []

  grid.each_index do |y|
    grid[y].each_index do |x|
      points << [y, x] if low_point? grid, y, x
    end
  end

  points
end

def solve1(filename)
  grid = read_input filename
  points = low_points grid
  points.inject(0) do |sum, point|
    y, x = point
    risk_level = grid[y][x] + 1
    sum + risk_level
  end
end

### Part 2

def basin(grid, start_y, start_x)
  found = Set[]
  inspect = Set[[start_y, start_x]]

  until inspect.empty?
    new = Set[]

    inspect.each do |y, x|
      found << [y, x]
      around(grid, y, x).each do |point|
        y, x = point
        new << point unless grid[y][x] == 9 || found.include?(point)
      end
    end

    inspect = new
  end

  found
end

def solve2(filename)
  grid = read_input filename
  points = low_points grid
  basins = points.collect { |y, x| basin grid, y, x }
  basins.collect(&:size).sort.last(3).inject(:*)
end
