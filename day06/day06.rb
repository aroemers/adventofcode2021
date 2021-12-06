# frozen_string_literal: true

def read_input(filename)
  tallied = File.read(filename).split(',').collect(&:to_i).tally
  (0..8).collect { |timer| tallied[timer] || 0 }
end

def solve(filename, days)
  state = read_input filename
  days.times do
    state = state.rotate
    state[6] += state[8]
  end
  state.sum
end
