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

def small_cave?(cave)
  cave.downcase == cave
end

def paths(graph, visiting, cannot_visit)
  from = visiting.last
  return [visiting] if from == 'end'

  visit = graph[from].reject { |to| cannot_visit.call(visiting, to) }
  visit.flat_map { |to| paths(graph, visiting.dup.push(to), cannot_visit) }
end

def solve1(filename)
  graph = read_input filename
  cannot_visit = proc { |visiting, cave| (small_cave? cave) && (visiting.include? cave) }
  paths(graph, ['start'], cannot_visit).size
end

### Part 2

def solve2(filename)
  graph = read_input filename
  cannot_visit = proc do |visiting, cave|
    if cave == 'start'
      true
    elsif !small_cave? cave
      false
    else
      small_visited = visiting.select { |visited| small_cave? visited }
      small_double = small_visited.tally.find { |_cave, count| count > 1 }
      small_double && cave == small_double.first || small_double && visiting.include?(cave)
    end
  end
  paths(graph, ['start'], cannot_visit).size
end
