# frozen_string_literal: true

def read_input(filename)
  lines = File.readlines(filename, chomp: true)

  template = lines[0]

  rules = {}
  lines.drop(2).each do |line|
    match = line.match(/(\w\w) -> (\w)/)
    rules[match[1].chars] = match[2]
  end

  [template, rules]
end

def initial_pairs(template)
  pairs = Hash.new(0)
  template.chars.each_cons(2) { |pair| pairs[pair] += 1 }
  pairs
end

def solve(template, rules, steps)
  pairs = initial_pairs template

  steps.times do
    new_pairs = Hash.new(0)
    pairs.each do |pair, count|
      new_pairs[[pair[0], rules[pair]]] += count
      new_pairs[[rules[pair], pair[1]]] += count
    end
    pairs = new_pairs
  end

  quantities = Hash.new(0)
  pairs.each do |pair, count|
    quantities[pair[0]] += count
    quantities[pair[1]] += count
  end
  quantities = quantities.transform_values { |count| (count / 2.0).round }

  sorted = quantities.sort_by { |_pair, count| count }
  sorted.last[1] - sorted.first[1]
end

def solve1(filename)
  template, rules = read_input filename
  solve template, rules, 10
end

def solve2(filename)
  template, rules = read_input filename
  solve template, rules, 40
end
