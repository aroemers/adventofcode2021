# frozen_string_literal: true

def solve1(filename)
  increases = 0
  last_measurement = 1000_000

  File.readlines(filename, chomp: true).each do |line|
    measurement = Integer(line)
    increases += 1 if measurement > last_measurement
    last_measurement = measurement
  end

  increases
end


def solve2(filename)
  increases = 0
  last_sum = 1000_000
  last_measurements = []

  File.readlines(filename, chomp: true).each do |line|
    last_measurements = last_measurements.prepend(Integer(line)).take(3)
    if last_measurements.length == 3
      new_sum = last_measurements.sum
      increases += 1 if new_sum > last_sum
      last_sum = new_sum
    end
  end

  increases
end
