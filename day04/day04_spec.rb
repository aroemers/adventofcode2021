# frozen_string_literal: true

require_relative 'day04'

RSpec.describe 'Solving day 4' do
  it 'should calculate the example for part 1' do
    expect(solve1('day04/example.txt')).to eq(4512)
  end
  it 'should calculate the input for part 1' do
    expect(solve1('day04/input.txt')).to eq(4662)
  end
  it 'should calculate the example for part 2' do
    expect(solve2('day04/example.txt')).to eq(1924)
  end
  it 'should calculate the input for part 2' do
    expect(solve2('day04/input.txt')).to eq(12_080)
  end
end
