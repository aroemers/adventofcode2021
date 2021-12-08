# frozen_string_literal: true

require_relative 'day08'

RSpec.describe 'Solving day 8' do
  it 'should calculate the example for part 1' do
    expect(solve1('day08/example.txt')).to eq(26)
  end
  it 'should calculate the input for part 1' do
    expect(solve1('day08/input.txt')).to eq(294)
  end
  it 'should calculate the example for part 2' do
    expect(solve2('day08/example.txt')).to eq(61_229)
  end
  it 'should calculate the input for part 2' do
    expect(solve2('day08/input.txt')).to eq(973_292)
  end
end
