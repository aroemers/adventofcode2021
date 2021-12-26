# frozen_string_literal: true

require 'set'

### Read and parse input

def read_input(filename)
  scanners = []

  File.readlines(filename, chomp: true).each do |line|
    if (matchinfo = line.match(/^--- scanner (\d+) ---/))
      scanners << []
    elsif (matchinfo = line.match(/^(-?\d+),(-?\d+),(-?\d+)/))
      scanners.last << [matchinfo[1], matchinfo[2], matchinfo[3]].collect(&:to_i)
    end
  end

  scanners
end

### Part 1

def geo_distance(point1, point2)
  Math.sqrt(
    (point1[0] - point2[0]).abs ** 2 +
    (point1[1] - point2[1]).abs ** 2 +
    (point1[2] - point2[2]).abs ** 2
  )
end

def distances(beacons)
  distances = {}

  0.upto(beacons.size - 2).each do |from_index|
    from_index.next.upto(beacons.size - 1).each do |to_index|
      from = beacons[from_index]
      to = beacons[to_index]

      distance = geo_distance(from, to)
      distances[distance] = Set[from_index, to_index]
    end
  end

  distances
end

def add(beacon1, beacon2)
  beacon1.zip(beacon2).collect { |i, j| i + j }
end

def subtract(beacon1, beacon2)
  beacon1.zip(beacon2).collect { |i, j| i - j }
end

def rotate(beacon, rotation)
  x, y, z = beacon
  [
    [x, y, z],
    [-x, y, -z],
    [-z, y, x],
    [z, y, -x],

    [y, -x, z],
    [-y, -x, -z],
    [-z, -x, y],
    [z, -x, -y],

    [-x, -y, z],
    [x, -y, -z],
    [-z, -y, -x],
    [z, -y, x],

    [-y, x, z],
    [y, x, -z],
    [-z, x, -y],
    [z, x, y],

    [x, -z, y],
    [-x, -z, y],
    [-y, -z, x],
    [y, -z, -x],

    [x, -y, -z],
    [-x, -y, -z],
    [z, -y, x],
    [-z, -y, -x],

    # Extra
    [-x, z, y],
    [x, z, -y],
    [-y, z, -x],
    [y, z, x],
    [-x, -z, -y]
  ][rotation]
end

def solve(filename)
  scanners = read_input filename
  scanner_positions = [[0, 0, 0]]

  distances = scanners.collect { |beacons| distances(beacons) }

  overlaps = {}
  0.upto(distances.size - 2).each do |from_index|
    from_index.next.upto(distances.size - 1).each do |to_index|
      from = distances[from_index]
      to = distances[to_index]
      next unless from.keys.&(to.keys).size >= 11

      overlaps[from_index] ||= []
      overlaps[from_index] << to_index
      overlaps[to_index] ||= []
      overlaps[to_index] << from_index
    end
  end

  p overlaps

  queue = [0]
  visited = Set[]
  until queue.empty?
    index = queue.pop
    visited << index

    from_beacons = scanners[index]
    from_distances = distances[index]
    overlaps[index].each do |overlap_index|
      next if visited.include? overlap_index

      p :___, index, overlap_index
      queue << overlap_index # unless visited.include? overlap_index
      visited << overlap_index

      to_beacons = scanners[overlap_index]
      to_distances = distances[overlap_index]

      overlap_distances = from_distances.keys.&(to_distances.keys)
      distance0 = overlap_distances[0]
      from_distance0_beacon_indices = from_distances[distance0]
      distance1 = overlap_distances.find do |distance|
        distance != distance0 && !from_distances[distance].&(from_distance0_beacon_indices).empty?
      end
      from_distance1_beacon_indices = from_distances[distance1]

      from_beacon_a = from_beacons[(from_distance0_beacon_indices & from_distance1_beacon_indices).first]
      from_beacon_b = from_beacons[(from_distance0_beacon_indices - from_distance1_beacon_indices).first]
      from_beacon_c = from_beacons[(from_distance1_beacon_indices - from_distance0_beacon_indices).first]

      to_distance0_beacon_indices = to_distances[distance0]
      to_distance1_beacon_indices = to_distances[distance1]

      to_beacon_a = to_beacons[(to_distance0_beacon_indices & to_distance1_beacon_indices).first]
      to_beacon_b = to_beacons[(to_distance0_beacon_indices - to_distance1_beacon_indices).first]
      to_beacon_c = to_beacons[(to_distance1_beacon_indices - to_distance0_beacon_indices).first]

      from_b_diff = subtract(from_beacon_b, from_beacon_a)
      from_c_diff = subtract(from_beacon_c, from_beacon_a)
      # p from_b_diff, from_c_diff
      to_b_diff = subtract(to_beacon_b, to_beacon_a)
      to_c_diff = subtract(to_beacon_c, to_beacon_a)

      rotation = 0.upto(28).find do |rot|
        #p rot, rotate(to_b_diff, rot), rotate(to_c_diff, rot)
        from_b_diff == rotate(to_b_diff, rot) && from_c_diff == rotate(to_c_diff, rot)
      end

      scanners[overlap_index] = to_beacons.collect do |beacon|
        add(from_beacon_a, rotate(subtract(beacon, to_beacon_a), rotation))
      end

      scanner_positions[overlap_index] = subtract(from_beacon_a, rotate(to_beacon_a, rotation))
    end
  end

  [
    scanners.flatten(1).uniq.size,
    scanner_positions
  ]
end

def solve1(filename)
  beacon_count, _ = solve filename
  beacon_count
end

def solve2(filename)
  _, scanner_positions = solve filename
  max_distance = 0
  scanner_positions.combination(2) do |p1, p2|
    distance = p subtract(p1, p2).collect(&:abs).sum
    max_distance = [max_distance, distance].max
  end
  max_distance
end
