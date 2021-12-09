# frozen_string_literal: true

require_relative 'day09'

RSpec.describe 'Solving day 9' do
  it 'should calculate the example for part 1' do
    expect(solve1('day09/example.txt')).to eq(15)
  end
  it 'should calculate the input for part 1' do
    expect(solve1('day09/input.txt')).to eq(489)
  end
  it 'should calculate the example for part 2' do
    expect(solve2('day09/example.txt')).to eq(1134)
  end
  it 'should calculate the input for part 2' do
    expect(solve2('day09/input.txt')).to eq(1_056_330)
  end
end
