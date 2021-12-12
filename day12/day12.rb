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

def paths(graph, visiting, twice_available)
  from = visiting.last
  return [visiting] if from == 'end'

  graph[from].flat_map do |to|
    may_visit = large_cave?(to) || !visiting.include?(to)
    if to != 'start' && (may_visit || twice_available)
      paths(graph, visiting.dup.push(to), twice_available && may_visit)
    else
      []
    end
  end
end

def solve1(filename)
  graph = read_input filename
  paths(graph, ['start'], false).size
end

### Part 2

def solve2(filename)
  graph = read_input filename
  paths(graph, ['start'], true).size
end
