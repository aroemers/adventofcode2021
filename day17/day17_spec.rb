# frozen_string_literal: true

require_relative 'day17'

RSpec.describe 'Solving day 17' do
  it 'should calculate the example for part 1' do
    expect(solve1('day17/example.txt')).to eq(45)
  end
  it 'should calculate the input for part 1' do
    expect(solve1('day17/input.txt')).to eq(9870)
  end
  it 'should calculate the example for part 2' do
    expect(solve2('day17/example.txt')).to eq(112)
  end
  it 'should calculate the input for part 2' do
    expect(solve2('day17/input.txt')).to eq(5523)
  end
end
