# frozen_string_literal: true

def solve1(filename)
  horizontal_pos = 0
  depth = 0

  File.readlines(filename, chomp: true).each do |command|
    operation, units = command.split(' ')
    units = Integer(units)

    case operation
    when 'forward'
      horizontal_pos += units
    when 'down'
      depth += units
    when 'up'
      depth -= units
    end
  end

  horizontal_pos * depth
end

def solve2(filename)
  horizontal_pos = 0
  depth = 0
  aim = 0

  File.readlines(filename, chomp: true).each do |command|
    operation, units = command.split(' ')
    units = Integer(units)

    case operation
    when 'forward'
      horizontal_pos += units
      depth += units * aim
    when 'down'
      aim += units
    when 'up'
      aim -= units
    end
  end

  horizontal_pos * depth
end
