# frozen_string_literal: true

require_relative 'day02'

RSpec.describe 'Solving day 2' do
  it 'should calculate the example for part 1' do
    expect(solve1('day02/example.txt')).to eq(150)
  end
  it 'should calculate the input for part 1' do
    expect(solve1('day02/input.txt')).to eq(1507611)
  end
  it 'should calculate the example for part 2' do
    expect(solve2('day02/example.txt')).to eq(900)
  end
  it 'should calculate the input for part 2' do
    expect(solve2('day02/input.txt')).to eq(1880593125)
  end
end
