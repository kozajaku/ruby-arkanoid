require_relative 'constants'

module Arkanoid
  module Model
    # Represents player's paddle in the game.
    class Paddle
      include Constants
      # x, y represents top side of paddle, bottom is (x, y + height)
      def initialize(game, x, y)
        @game = game
        @pos_x = x
        @pos_y = y
        @height = PADDLE_SIZE
        @speed = PADDLE_MOVE_STEP
      end

      #try to move the paddle up if possible
      def move_up
        next_y = @pos_y - @speed
        next_y = @game.top_wall if next_y < @game.top_wall
        @pos_y = next_y
      end

      # try to move the paddle down if possible
      def move_down
        next_y = @pos_y + @speed
        next_y = @game.bottom_wall - @height if next_y + @height > @game.bottom_wall
        @pos_y = next_y
      end

      # Detects collision with the ball. If it happens
      # bounces ball back to the game.
      def ball_collision(ball)
        angle = ball.angle
        if 90 < angle and angle < 270
          # detect bounce from the right side
          ball_right_collision(ball)
        elsif angle < 90 or angle > 270
          # detect bounce from the left side
          ball_left_collision(ball)
        end
      end

      private

      # Detects collision of ball to the paddle from the right side.
      def ball_right_collision(ball)
        return if @pos_x > ball.x # ball is already behind the paddle
        col = collision_y_point(ball)
        return if col.nil?
        d = col - (@pos_y + @height / 2.0)
        ball.angle = count_output_angle(ball.angle, d)
        # outbounce
        delta = ball.x - ball.radius - @pos_x
        if delta < 0
          ball.x = @pos_x - delta + ball.radius
        end
      end

      # Detects collision of ball to the paddle from the left side.
      def ball_left_collision(ball)
        return if @pos_x < ball.x # ball is already behind the paddle
        col = collision_y_point(ball)
        return if col.nil?
        d = (@pos_y + @height / 2.0) - col
        ball.angle = count_output_angle(ball.angle, d)
        # outbounce
        delta = @pos_x - (ball.x + ball.radius)
        if delta < 0
          ball.x = @pos_x + delta - ball.radius
        end
      end

      # Counts output angle after collision with paddle.
      def count_output_angle(incoming_angle, d)
        z_angle = Math.atan(PADDLE_BOUNCE_CONSTANT * d / @height)
        incoming_angle = (incoming_angle + 180) % 360 # take inverted vector
        incoming_angle = incoming_angle / 180.0 * Math::PI # convert to radians
        out_angle = 2 * z_angle - incoming_angle
        out_angle = out_angle / Math::PI * 180.0 # convert to degrees
        out_angle %= 360
        out_angle
      end

      # Tries to find y coordinate of collision of ball with paddle.
      # If there is no such collision, returns nil.
      def collision_y_point(ball)
        b = -2 * ball.y
        c = (ball.y ** 2) - (ball.radius ** 2) + ((@pos_x - ball.x) ** 2)
        discriminant = b ** 2 - 4 * c
        return nil if discriminant < 0 # no collision with paddle
        # it is still possible that there is no collision
        y1 = (-b + Math.sqrt(discriminant)) / 2.0
        y2 = (-b - Math.sqrt(discriminant)) / 2.0
        py1 = @pos_y
        py2 = @pos_y + @height
        if y1.between?(py1, py2) and y2.between?(py1, py2)
          # both collision points are on the paddle - return avg
          (y1 + y2) / 2
        elsif y1.between?(py1, py2) or y2.between(py1, py2)
          # exactly one point is on the paddle
          avg = (y1 + y2) / 2
          if avg.between?(py1, py2)
            avg
          elsif avg < py1
            py1
          else
            py2
          end
        else
          nil
        end
      end
    end
  end
end