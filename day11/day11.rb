# frozen_string_literal: true

### Read and parse input

def read_input(filename)
  File.readlines(filename, chomp: true).collect do |line|
    line.chars.collect(&:to_i)
  end
end

### Part 1

NEIGHBOURS = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]].freeze

def neighbours(grid, y, x)
  moved = NEIGHBOURS.collect { |ny, nx| [y + ny, x + nx] }
  moved.reject { |ny, nx| ny.negative? || ny >= grid.size || nx.negative? || nx >= grid[0].size }
end

def step(grid)
  # Increase energy of each octopus by 1
  grid = grid.collect do |xs|
    xs.collect(&:next)
  end

  # Flashes
  flashed = Set[]

  loop do
    will_flash = Set[]
    grid.each_index do |y|
      xs = grid[y]
      xs.each_index do |x|
        will_flash << [y, x] if xs[x] > 9 && !flashed.include?([y, x])
      end
    end

    break if will_flash.empty?

    will_flash.each do |y, x|
      neighbours(grid, y, x).each do |ny, nx|
        grid[ny][nx] += 1
      end
    end

    flashed |= will_flash
  end

  # Reset energy of flashed
  flashed.each do |y, x|
    grid[y][x] = 0
  end

  grid
end

def solve1(filename)
  grid = read_input filename
  flashes = 0

  100.times do
    grid = step(grid)
    flashes += grid.flatten.count(&:zero?)
  end

  flashes
end

### Part 2

def solve2(filename)
  grid = read_input filename
  steps = 0

  until grid.flatten.all?(&:zero?)
    steps += 1
    grid = step(grid)
  end

  steps
end
