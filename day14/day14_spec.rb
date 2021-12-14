# frozen_string_literal: true

require_relative 'day14'

RSpec.describe 'Solving day 14' do
  it 'should calculate the example for part 1' do
    expect(solve1('day14/example.txt')).to eq(1588)
  end
  it 'should calculate the input for part 1' do
    expect(solve1('day14/input.txt')).to eq(3259)
  end
  it 'should calculate the example for part 2' do
    expect(solve2('day14/example.txt')).to eq(2_188_189_693_529)
  end
  it 'should calculate the input for part 2' do
    expect(solve2('day14/input.txt')).to eq(3_459_174_981_021)
  end
end
