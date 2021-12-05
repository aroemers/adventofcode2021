# frozen_string_literal: true

require_relative 'day05'

RSpec.describe 'Solving day 5' do
  it 'should calculate the example for part 1' do
    expect(solve1('day05/example.txt')).to eq(5)
  end
  it 'should calculate the input for part 1' do
    expect(solve1('day05/input.txt')).to eq(6311)
  end
  it 'should calculate the example for part 2' do
    expect(solve2('day05/example.txt')).to eq(12)
  end
  it 'should calculate the input for part 2' do
    expect(solve2('day05/input.txt')).to eq(19_929)
  end
end
