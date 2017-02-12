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
        paddle_y = @height / 2 - PADDLE_SIZE / 2
        @paddles = [Paddle.new(self, PADDLE_LEFT_X, paddle_y, true), Paddle.new(self, PADDLE_RIGHT_X, paddle_y, false)]
        @balls = []
        @paddles.each { |paddle| @balls << paddle.create_new_ball }
        # @balls = (-70..70).collect { |i| Ball.new(self, 40, 400, i) }
        # @balls = [Ball.new(self, 10, 200, -45),Ball.new(self, 10, 200, -20),Ball.new(self, 10, 200, 0),Ball.new(self, 10, 200, 20),Ball.new(self, 10, 200, 45)]
      end

      # This method is called every frame. It provides movement
      # for every element that is capable of doing so.
      def tick
        @balls.each do |ball|
          ball.move
        end
      end

      # This method is called by controller when player 1 clicks move paddle down.
      def paddle_left_down
        @paddles[0].move_down
      end

      # This method is called by controller when player 1 clicks move paddle up.
      def paddle_left_up
        @paddles[0].move_up
      end

      # This method releases all balls that are caught by this paddle.
      def paddle_left_release
        @paddles[0].release_all_balls
      end

      # This method is called by controller when player 2 clicks move paddle down.
      def paddle_right_down
        @paddles[1].move_down
      end

      # This method is called by controller when player 2 clicks move paddle up.
      def paddle_right_up
        @paddles[1].move_up
      end

      # This method releases all balls that are caught by this paddle.
      def paddle_right_release
        @paddles[1].release_all_balls
      end

      # Accept generic visitor for visiting components. This could be used for example
      # for components drawing to ensure low coupling in model tier.
      def accept_visitor(visitor)
        #todo visit blocks
        #todo visit bonuses
        visitor.visit_left_paddle(@paddles[0])
        visitor.visit_right_paddle(@paddles[1])
        @balls.each { |ball| visitor.visit_ball(ball) }
      end

      def ball_lost(ball)
        #todo implement game action
        @balls.delete(ball)
      end
    end
  end
end
