# frozen_string_literal: true

require_relative 'day19'

RSpec.describe 'Solving day 19' do
  it 'should calculate the example for part 1' do
    expect(solve1('day19/example.txt')).to eq(79)
  end
  it 'should calculate the input for part 1' do
    expect(solve1('day19/input.txt')).to eq(491)
  end
  it 'should calculate the example for part 2' do
    expect(solve2('day19/example.txt')).to eq(3621)
  end
  it 'should calculate the input for part 2' do
    expect(solve2('day19/input.txt')).to eq(133_74)
  end
end
