# frozen_string_literal: true

require_relative 'day16'

RSpec.describe 'Solving day 16' do
  it 'should calculate the example for part 1' do
    expect(solve1('day16/example.txt')).to eq(31)
  end
  it 'should calculate the input for part 1' do
    expect(solve1('day16/input.txt')).to eq(871)
  end
  it 'should calculate the example for part 2' do
    expect(solve2('day16/example.txt')).to eq(54)
  end
  it 'should calculate the input for part 2' do
    expect(solve2('day16/input.txt')).to eq(68_703_010_504)
  end
end
