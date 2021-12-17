# frozen_string_literal: true

### Read and parse input

def read_input(filename)
  regexp = /target area: x=(-?\d+)..(-?\d+), y=(-?\d+)..(-?\d+)/
  matchinfo = File.read(filename, chomp:true).match(regexp)
  [
    matchinfo[1].to_i..matchinfo[2].to_i,
    matchinfo[3].to_i..matchinfo[4].to_i
  ]
end

### Part 1

def solve(y_target)
  heights = []

  y_target.first.upto(y_target.first * -1).each do |i|
    y = 0
    y_velocity = i
    max_height = 0
    steps = 0

    while y > y_target.min
      y += y_velocity
      max_height = [max_height, y].max
      steps += 1
      y_velocity -= 1

      heights << [i, max_height, steps] if y_target.include? y
    end
  end

  heights
end

def solve1(filename)
  _x_target, y_target = read_input filename
  heights = solve(y_target)
  heights.collect { |_y_velocity, max_height| max_height }.max
end

### Part 2

def x_after_steps(x_velocity, steps)
  x = 0

  while x_velocity.positive? && steps.positive?
    x += x_velocity
    x_velocity -= 1
    steps -= 1
  end

  x
end

def solve2(filename)
  x_target, y_target = read_input filename
  heights = solve(y_target)

  velocities = []
  heights.each do |y_velocity, _max_height, steps|
    1.upto(x_target.last).each do |x_velocity|
      final_x = x_after_steps(x_velocity, steps)
      velocities << [x_velocity, y_velocity] if x_target.include? final_x
    end
  end

  velocities.uniq.count
end
