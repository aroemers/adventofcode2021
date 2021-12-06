# frozen_string_literal: true

require_relative 'day06'

RSpec.describe 'Solving day 6' do
  it 'should calculate the example for part 1' do
    expect(solve('day06/example.txt', 80)).to eq(5934)
  end
  it 'should calculate the input for part 1' do
    expect(solve('day06/input.txt', 80)).to eq(349_549)
  end
  it 'should calculate the example for part 2' do
    expect(solve('day06/example.txt', 256)).to eq(26_984_457_539)
  end
  it 'should calculate the input for part 2' do
    expect(solve('day06/input.txt', 256)).to eq(1_589_590_444_365)
  end
end
