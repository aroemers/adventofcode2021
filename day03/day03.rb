# frozen_string_literal: true

def read_bits(filename)
  bits = []

  File.readlines(filename, chomp: true).each do |number|
    bits.push(number.chars.collect(&:to_i))
  end

  bits
end

def solve1(filename)
  totals = []
  bits = read_bits(filename)

  bits.each do |number|
    number.each_index do |index|
      totals[index] ||= 0
      totals[index] += number[index]
    end
  end

  gamma = totals.collect { |total| total > bits.size / 2 ? 1 : 0}.join.to_i(2)
  epsilon = totals.collect { |total| total < bits.size / 2 ? 1 : 0}.join.to_i(2)

  gamma * epsilon
end

def find_number(bits, significant, insignificant)
  index = 0
  while bits.size > 1
    total = 0
    bits.each do |number|
      total += number[index]
    end

    significance = total >= (bits.size / 2.0).round ? significant : insignificant

    bits = bits.select do |number|
      number[index] == significance
    end

    index += 1
  end
  bits.first
end

def solve2(filename)
  bits = read_bits(filename)

  oxygen_generator = find_number(bits, 1, 0).join.to_i(2)
  co2_scrubber = find_number(bits, 0, 1).join.to_i(2)

  oxygen_generator * co2_scrubber
end
