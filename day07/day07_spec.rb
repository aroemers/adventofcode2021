# frozen_string_literal: true

require_relative 'day07'

RSpec.describe 'Solving day 7' do
  it 'should calculate the example for part 1' do
    expect(solve1('day07/example.txt')).to eq(37)
  end
  it 'should calculate the input for part 1' do
    expect(solve1('day07/input.txt')).to eq(348_996)
  end
  it 'should calculate the example for part 2' do
    expect(solve2('day07/example.txt')).to eq(168)
  end
  it 'should calculate the input for part 2' do
    expect(solve2('day07/input.txt')).to eq(98_231_647)
  end
end
