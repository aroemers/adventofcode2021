# frozen_string_literal: true

require_relative 'day11'

RSpec.describe 'Solving day 11' do
  it 'should calculate the example for part 1' do
    expect(solve1('day11/example.txt')).to eq(1656)
  end
  it 'should calculate the input for part 1' do
    expect(solve1('day11/input.txt')).to eq(1640)
  end
  it 'should calculate the example for part 2' do
    expect(solve2('day11/example.txt')).to eq(195)
  end
  it 'should calculate the input for part 2' do
    expect(solve2('day11/input.txt')).to eq(312)
  end
end
