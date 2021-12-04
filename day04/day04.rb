# frozen_string_literal: true

class Board
  def initialize(lines)
    @lines = lines
  end

  def mark(number)
    new_lines = @lines.collect do |line|
      line.collect { |line_number| line_number == number ? nil : line_number }
    end
    Board.new(new_lines)
  end

  def won?
    @lines.find { |line| line.all?(&:nil?) } ||
      @lines.transpose.find { |line| line.all?(&:nil?) }
  end

  def score
    @lines.reduce(0) { |s, board_line| s + board_line.reject(&:nil?).sum }
  end
end

def read_input(filename)
  lines = File.readlines(filename, chomp: true)
  numbers = lines.first.split(',').collect(&:to_i)

  boards = []
  lines.drop(2).reject(&:empty?).each_slice(5) do |board_lines|
    board = board_lines.collect do |board_line|
      board_line.split(' ').collect(&:to_i)
    end
    boards.append Board.new(board)
  end

  [numbers, boards]
end

def solve1(filename)
  numbers, boards = read_input filename

  numbers.each do |number|
    boards = boards.collect { |board| board.mark(number) }
    winner = boards.find(&:won?)
    next unless winner

    return winner.score * number
  end
end

def solve2(filename)
  numbers, boards = read_input filename

  numbers.each do |number|
    boards = boards.collect { |board| board.mark(number) }
    winners, boards = boards.partition(&:won?)
    next unless boards.empty?

    loser = winners.first
    return loser.score * number
  end
end
