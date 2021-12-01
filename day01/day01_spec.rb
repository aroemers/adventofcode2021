# frozen_string_literal: true

require_relative 'day01'

RSpec.describe 'Solving day 1' do
  it 'should calculate the example for part 1' do
    expect(solve1('day01/example.txt')).to eq(7)
  end
  it 'should calculate the input for part 1' do
    expect(solve1('day01/input.txt')).to eq(1387)
  end
  it 'should calculate the example for part 2' do
    expect(solve2('day01/example.txt')).to eq(5)
  end
  it 'should calculate the input for part 2' do
    expect(solve2('day01/input.txt')).to eq(1362)
  end
end
