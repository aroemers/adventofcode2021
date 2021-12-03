# frozen_string_literal: true

require_relative 'day03'

RSpec.describe 'Solving day 3' do
  it 'should calculate the example for part 1' do
    expect(solve1('day03/example.txt')).to eq(198)
  end
  it 'should calculate the input for part 1' do
    expect(solve1('day03/input.txt')).to eq(2261546)
  end
  it 'should calculate the example for part 2' do
    expect(solve2('day03/example.txt')).to eq(230)
  end
  it 'should calculate the input for part 2' do
    expect(solve2('day03/input.txt')).to eq(6775520)
  end
end
