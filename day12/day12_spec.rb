# frozen_string_literal: true

require_relative 'day12'

RSpec.describe 'Solving day 12' do
  it 'should calculate the example for part 1' do
    expect(solve1('day12/example.txt')).to eq(10)
  end
  it 'should calculate the input for part 1' do
    expect(solve1('day12/input.txt')).to eq(4691)
  end
  it 'should calculate the example for part 2' do
    expect(solve2('day12/example.txt')).to eq(36)
  end
  it 'should calculate the input for part 2' do
    expect(solve2('day12/input.txt')).to eq(140_718)
  end
end
