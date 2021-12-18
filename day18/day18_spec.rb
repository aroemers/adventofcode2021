# frozen_string_literal: true

require_relative 'day18'

RSpec.describe 'Solving day 18' do
  it 'should calculate the example for part 1' do
    expect(solve1('day18/example.txt')).to eq(4140)
  end
  it 'should calculate the input for part 1' do
    expect(solve1('day18/input.txt')).to eq(4417)
  end
  it 'should calculate the example for part 2' do
    expect(solve2('day18/example.txt')).to eq(3993)
  end
  it 'should calculate the input for part 2' do
    expect(solve2('day18/input.txt')).to eq(4796)
  end
end
