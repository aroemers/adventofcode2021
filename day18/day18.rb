# frozen_string_literal: true

### Read and parse input

def read_input(filename)
  File.readlines(filename, chomp: true).collect { |line| eval line }
end

### Part 1

def bf_search(tree, found)
  queue = [[1], [0]]
  before = []
  after = []
  at = nil

  until queue.empty?
    path = queue.pop
    item = tree.dig(*path)

    if !at && found.call(path, item)
      before = after
      after = []
      at = path
    end

    if item.is_a? Array
      queue.push path.dup << 1
      queue.push path.dup << 0
    else
      after << path
    end
  end

  [before, at, after]
end

def update_in(tree, path, block)
  if path.size == 1
    tree[path.first] = block.call(tree[path.first])
  else
    update_in(tree[path.first], path.drop(1), block)
  end
  tree
end

def deep_dup(tree)
  Marshal.load(Marshal.dump(tree))
end

def add(tree, add)
  [deep_dup(tree), deep_dup(add)]
end

def reduce(tree)
  continue = true

  while continue
    # Explode
    before, at, after = bf_search(tree, proc { |path, item|
      item.is_a?(Array) && path.length == 4
    })

    if at
      to_explode = tree.dig(*at)
      update_in(tree, before.last, proc { |x| x + to_explode[0] }) unless before.empty?
      update_in(tree, after[2], proc { |x| x + to_explode[1] }) if after[2]
      update_in(tree, at, proc { |_x| 0 })
      next
    end

    # Split
    before, at, after = bf_search(tree, proc { |_path, item|
      item.is_a?(Integer) && item >= 10
    })

    if at
      update_in(tree, at, proc { |x| [x / 2, (x / 2.0).round] })
      next
    end

    # Done
    continue = false
  end

  tree
end

def magnitude(tree)
  if tree.is_a? Array
    3 * magnitude(tree[0]) + 2 * magnitude(tree[1])
  else
    tree
  end
end

def solve1(filename)
  numbers = read_input filename
  tree = numbers[0]

  numbers.drop(1).each do |number|
    tree = add tree, number
    tree = reduce tree
  end

  magnitude tree
end

### Part 2

def solve2(filename)
  numbers = read_input filename

  max = 0
  numbers.permutation(2) do |number1, number2|
    max = [max, magnitude(reduce(add(number1, number2)))].max
  end

  max
end
