# frozen_string_literal: true

require_relative 'day15'

RSpec.describe 'Solving day 15' do
  it 'should calculate the example for part 1' do
    expect(solve1('day15/example.txt')).to eq(40)
  end
  it 'should calculate the input for part 1' do
    expect(solve1('day15/input.txt')).to eq(604)
  end
  it 'should calculate the example for part 2' do
    expect(solve2('day15/example.txt')).to eq(315)
  end
  it 'should calculate the input for part 2' do
    expect(solve2('day15/input.txt')).to eq(2907)
  end
end
