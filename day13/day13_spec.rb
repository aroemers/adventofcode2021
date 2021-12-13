# frozen_string_literal: true

require_relative 'day13'

RSpec.describe 'Solving day 13' do
  it 'should calculate the example for part 1' do
    expect(solve1('day13/example.txt')).to eq(17)
  end
  it 'should calculate the input for part 1' do
    expect(solve1('day13/input.txt')).to eq(818)
  end
  it 'should calculate the example for part 2' do
    expect(solve2('day13/example.txt')).to eq('#####
                                               #...#
                                               #...#
                                               #...#
                                               #####'.delete ' ')
  end
  it 'should calculate the input for part 2' do
    # LRGPRECB
    expect(solve2('day13/input.txt')).to eq('#....###...##..###..###..####..##..###.
                                             #....#..#.#..#.#..#.#..#.#....#..#.#..#
                                             #....#..#.#....#..#.#..#.###..#....###.
                                             #....###..#.##.###..###..#....#....#..#
                                             #....#.#..#..#.#....#.#..#....#..#.#..#
                                             ####.#..#..###.#....#..#.####..##..###.'.delete ' ')
  end
end
