# frozen_string_literal: true

require_relative 'day20'

RSpec.describe 'Solving day 20' do
  it 'should calculate the example for part 1' do
    expect(solve1('day20/example.txt')).to eq(35)
  end
  it 'should calculate the input for part 1' do
    expect(solve1('day20/input.txt')).to eq(5306)
  end
  it 'should calculate the example for part 2' do
    expect(solve2('day20/example.txt')).to eq(3351)
  end
  it 'should calculate the input for part 2' do
    expect(solve2('day20/input.txt')).to eq(17_497)
  end
end
