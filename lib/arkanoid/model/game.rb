require_relative 'constants'
require_relative 'ball'
require_relative 'paddle'

module Arkanoid
  module Model
    # Represents model of the whole game. It contains references
    # to all elements that are inside the game and
    # provides API for communication with the View and Controller tier.
    class Game
      include Constants

      attr_reader :top_wall, :bottom_wall
      attr_reader :width, :height
      attr_reader :paddles, :balls

      def initialize(map)
        @map = map
        @top_wall = TOP_WALL_Y
        @bottom_wall = BOTTOM_WALL_Y
        @width = GAME_WIDTH
        @height = GAME_HEIGHT
        @balls = [Ball.new(self, 10, 200, 45)]
        @paddles = [Paddle.new(self, 0, 70), Paddle.new(self, 500, 110)]
      end

      # This method is called every frame. It provides movement
      # for every element that is capable of doing so.
      def tick
        @balls.each do |ball|
          ball.move
          puts ball
        end
      end
    end
  end
end
