# frozen_string_literal: true

### Read and parse input

def read_input(filename)
  line = File.read(filename, chomp: true)
  line.hex.to_s(2).rjust((line.size - 1) * 4, '0') # there must be a better way...
end

### Part 1

def parse_literal(bitstring)
  bits = ''
  read = 0

  loop do
    bits += bitstring[1, 4]
    read += 5
    break if bitstring[0] == '0'

    bitstring = bitstring[5..]
  end

  [{ value: bits.to_i(2) }, read]
end

def parse_control(type_id, bitstring)
  length_type_id = bitstring[0].to_i(2)
  subpackets = []
  read = 1

  if length_type_id.zero?
    length = bitstring[1, 15].to_i(2)
    read += 15
    bitstring = bitstring[16..]

    until length.zero?
      parsed, subread = parse_packet(bitstring)
      subpackets << parsed
      read += subread
      length -= subread
      bitstring = bitstring[subread..]
    end
  else
    subpackets_count = bitstring[1, 11].to_i(2)
    read += 11
    bitstring = bitstring[12..]

    subpackets_count.times do
      parsed, subread = parse_packet(bitstring)
      subpackets << parsed
      read += subread
      bitstring = bitstring[subread..]
    end
  end

  value =
    case type_id
    when 0
      subpackets.inject(0) { |sum, subpacket| sum + subpacket[:value] }
    when 1
      subpackets.inject(1) { |product, subpacket| product * subpacket[:value] }
    when 2
      subpackets.collect { |subpacket| subpacket[:value] }.min
    when 3
      subpackets.collect { |subpacket| subpacket[:value] }.max
    when 5
      subpackets[0][:value] > subpackets[1][:value] ? 1 : 0
    when 6
      subpackets[0][:value] < subpackets[1][:value] ? 1 : 0
    when 7
      subpackets[0][:value] == subpackets[1][:value] ? 1 : 0
    end

  [{ packets: subpackets, length_type_id: length_type_id, value: value }, read]
end

def parse_packet(bitstring)
  version = bitstring[0, 3].to_i(2)
  type_id = bitstring[3, 3].to_i(2)
  remainder = bitstring[6..]

  parsed, read =
    if type_id == 4
      parse_literal(remainder)
    else
      parse_control(type_id, remainder)
    end

  [parsed.merge({ type_id: type_id, version: version }), read + 6]
end

def read_version_sum(packet)
  subpackets = packet[:packets]
  if subpackets
    subpackets.inject(packet[:version]) { |sum, subpacket| sum + read_version_sum(subpacket) }
  else
    packet[:version]
  end
end

def solve1(filename)
  bitstring = read_input filename
  packet, _read = parse_packet(bitstring)
  read_version_sum packet
end

### Part 2

def solve2(filename)
  bitstring = read_input filename
  packet, _read = parse_packet(bitstring)
  packet[:value]
end
