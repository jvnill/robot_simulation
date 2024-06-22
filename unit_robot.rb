require './board'
require './command'
require './simulation'
require 'pry'

BOARD_WIDTH = 5
BOARD_LENGTH = 5

board = Board.new(BOARD_LENGTH, BOARD_WIDTH)
simulation = Simulation.new(board)

loop do
  command = gets.chomp

  break if command.downcase == 'exit'

  Command.new(command, simulation).process
end
