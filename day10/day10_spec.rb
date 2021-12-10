# frozen_string_literal: truee

require_relative 'day10'

RSpec.describe 'Solving day 10' do
  it 'should calculate the example for part 1' do
    expect(solve1('day10/example.txt')).to eq(26_397)
  end
  it 'should calculate the input for part 1' do
    expect(solve1('day10/input.txt')).to eq(392_097)
  end
  it 'should calculate the example for part 2' do
    expect(solve2('day10/example.txt')).to eq(288_957)
  end
  it 'should calculate the input for part 2' do
    expect(solve2('day10/input.txt')).to eq(4263222782)
  end
end
