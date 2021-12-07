# frozen_string_literal: true

def read_input(filename)
  File.read(filename).split(',').collect(&:to_i)
end

def calculate_cost1(positions, target)
  positions.inject(0) { |cost, position| cost += (position - target).abs }
end

def solve1(filename)
  positions = read_input(filename)
  middle = positions.sort[positions.size / 2]
  calculate_cost1(positions, middle)
end

def triangular_number(n)
  n * (n + 1) / 2
end

def calculate_cost2(positions, target)
  positions.inject(0) { |cost, position| cost += triangular_number((position - target).abs) }
end

def solve2(filename)
  positions = read_input(filename)
  average_floor = positions.sum / positions.size
  [
    calculate_cost2(positions, average_floor),
    calculate_cost2(positions, average_floor + 1)
  ].min
end
