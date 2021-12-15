# frozen_string_literal: true

require 'priority_queue'

### Parse input

def neighbours(grid, y, x)
  points = []

  points << [y - 1, x] unless y == 0
  points << [y + 1, x] unless y == grid.size - 1
  points << [y, x - 1] unless x == 0
  points << [y, x + 1] unless x == grid[0].size - 1

  points
end

def read_input(filename)
  File.readlines(filename, chomp: true).collect { |line| line.chars.collect(&:to_i) }
end

### Part 1

def grid_to_graph(grid)
  graph = {}

  0.upto(grid.size - 1).each do |y|
    0.upto(grid[0].size - 1).each do |x|
      weights = {}
      neighbours(grid, y, x).each do |ny, nx|
        weights[[ny, nx]] = grid[ny][nx]
      end
      graph[[y, x]] = weights
    end
  end

  graph
end

def dijkstra(graph, start, target)
  unvisited = PriorityQueue.new
  unvisited[start] = 0

  visited = Set[]
  distances = { start => 0 }
  distances.default = Float::INFINITY

  until unvisited.empty?
    current, distance = unvisited.delete_min
    visited.add current

    neighbours = graph[current]
    neighbours.each do |neighbour, weight|
      next if visited.include? neighbour

      neighbour_distance = distances[neighbour]
      new_distance = distance + weight

      if new_distance < neighbour_distance
        distances[neighbour] = new_distance
        unvisited[neighbour] = new_distance
      end
    end

    return distances if current == target
  end

  nil
end

def solve1(filename)
  grid = read_input filename
  graph = grid_to_graph grid
  target = [grid.size - 1, grid[0].size - 1]

  distances = dijkstra(graph, [0, 0], target)
  distances[target]
end

### Part 2

def expand_grid(grid, count)
  original_size = grid.size

  original_size.upto(original_size * count - 1).each do |index|
    grid[index] = grid[index - original_size].collect { |risk| [1, risk.next % 10].max }
  end

  grid = grid.transpose

  original_size.upto(original_size * count - 1).each do |index|
    grid[index] = grid[index - original_size].collect { |risk| [1, risk.next % 10].max }
  end

  grid.transpose
end

def solve2(filename)
  grid = read_input filename
  expanded = expand_grid grid, 5
  graph = grid_to_graph expanded
  target = [expanded.size - 1, expanded[0].size - 1]

  distances = dijkstra(graph, [0, 0], target)
  distances[target]
end
