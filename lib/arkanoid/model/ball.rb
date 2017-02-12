require_relative 'constants'

module Arkanoid
  module Model
    #This class represents a ball in the game.
    class Ball
      include Constants

      attr_reader :radius
      attr_accessor :angle, :x, :y, :pos_x, :pos_y
      alias_method :x, :pos_x
      alias_method :y, :pos_y


      def initialize(game, x, y, angle, speed=BALL_SPEED, radius=BALL_RADIUS)
        @pos_x = x
        @pos_y = y
        @angle = angle # move angle in degrees
        @speed = speed
        @radius = radius
        @game = game
      end

      def move
        # count move vectors
        x_move = @speed * Math.cos(radian_angle)
        y_move = @speed * Math.sin(radian_angle)
        next_x = @pos_x + x_move
        next_y = @pos_y + y_move
        # detect top wall bounces
        next_y = top_wall_bounce(next_y)
        # detect bottom wall bounces
        next_y = bottom_wall_bounce(next_y)
        @pos_x = next_x
        @pos_y = next_y
        # detect paddle bounce
        @game.paddles.each { |paddle| paddle.ball_collision(self) }
        # todo implement block bounces
        # detect ball out of game
        detect_ball_out
      end

      # Gets current angle in radians
      def radian_angle
        @angle * Math::PI / 180.0
      end

      # Converting to str for debug purposes.
      def to_s
        "[#{@pos_x}, #{@pos_y}, #{@angle}]"
      end

      private

      # Detect bounce against top wall.
      # If it bounces, returns new y coordinate of ball, changes angle if necessary.
      def top_wall_bounce(next_y)
        delta = next_y - @radius - @game.top_wall
        if delta <= 0
          # do bounce
          next_y = @game.top_wall - delta + @radius
          # count new move angle
          mirror_angle_horizontally!
        end
        next_y
      end

      # Detect bounce against bottom wall.
      # If it bounces, returns new y coordinate of ball, changes angle if necessary.
      def bottom_wall_bounce(next_y)
        delta = @game.bottom_wall - next_y - @radius
        if delta <= 0
          # do bounce
          next_y = @game.bottom_wall + delta - @radius
          mirror_angle_horizontally!
        end
        next_y
      end


      # angle mirror projection around y axis. eg. for 280 -> 260, 120 -> 60, ...
      def mirror_angle_horizontally!
        @angle = (-@angle) % 360
      end

      def detect_ball_out
        if x + radius < 0 or y + radius < 0 or
            x - radius > @game.width or y - radius > @game.height
          @game.ball_lost(self)
        end
      end

    end #Ball
  end #Model
end #module
