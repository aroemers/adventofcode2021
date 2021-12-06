# frozen_string_literal: true

def read_input(filename)
  state = File.read(filename).split(',').collect(&:to_i).tally
  state.default = 0
  state
end

def solve(filename, days)
  state = read_input filename
  days.times do
    spawn = state[0]
    (0..7).each { |timer| state[timer] = state[timer + 1] }
    state[8] = spawn
    state[6] += spawn
  end
  state.values.sum
end
