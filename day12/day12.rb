# frozen_string_literal: true

### Read and parse input into a bidirectional graph hash

def read_input(filename)
  graph = {}

  File.readlines(filename, chomp: true).each do |line|
    from, to = line.split '-'
    graph[from] ||= []
    graph[from] << to
    graph[to] ||= []
    graph[to] << from
  end

  graph.freeze
end

### Part 1

def large_cave?(cave)
  cave.upcase == cave
end

def paths(graph, visiting, rule, rule_state)
  from = visiting.last
  return [visiting] if from == 'end'

  graph[from].flat_map do |to|
    new_rule_state = rule.call rule_state, visiting, to
    if new_rule_state
      paths(graph, visiting.dup.push(to), rule, new_rule_state)
    else
      []
    end
  end
end

def solve1(filename)
  rule = proc { |_state, visiting, to| large_cave?(to) || !visiting.include?(to) }

  graph = read_input filename
  paths(graph, ['start'], rule, nil).size
end

### Part 2

def solve2(filename)
  rule = proc do |state, visiting, to|
    if to == 'start'
      nil
    elsif large_cave? to
      state
    elsif visiting.include? to
      { twice: true } unless state[:twice]
    else
      state
    end
  end

  graph = read_input filename
  paths(graph, ['start'], rule, { twice: false }).size
end
