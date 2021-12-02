# frozen_string_literal: true

def solve1(filename)
  increases = 0
  last_measurement = nil

  File.readlines(filename, chomp: true).each do |line|
    measurement = Integer(line)
    increases += 1 if last_measurement && last_measurement < measurement
    last_measurement = measurement
  end

  increases
end

def solve2(filename)
  increases = 0
  last_sum = nil
  last_measurements = []

  File.readlines(filename, chomp: true).each do |line|
    last_measurements = last_measurements.prepend(Integer(line)).take(3)
    next unless last_measurements.length == 3

    new_sum = last_measurements.sum
    increases += 1 if last_sum && last_sum < new_sum
    last_sum = new_sum
  end

  increases
end
