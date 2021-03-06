require_relative 'constants'
require_relative 'ball'

module Arkanoid
  module Model
    # Represents player's paddle in the game.
    class Paddle
      include Constants

      attr_accessor :pos_x, :pos_y, :height, :catchy, :speed
      attr_reader :game, :left_paddle
      alias x pos_x
      alias y pos_y
      # x, y represents top side of paddle, bottom is (x, y + height)
      def initialize(game, x, y, left_paddle)
        @game = game
        @pos_x = x
        @pos_y = y
        @height = PADDLE_SIZE
        @speed = PADDLE_MOVE_STEP
        @left_paddle = left_paddle
        @caught_balls = []
        @catchy = false
      end

      # try to move the paddle up if possible
      def move_up
        next_y = @pos_y - @speed
        next_y = @game.top_wall if next_y < @game.top_wall
        delta = next_y - @pos_y
        @pos_y = next_y
        @caught_balls.each { |ball| ball.pos_y += delta }
      end

      # try to move the paddle down if possible
      def move_down
        next_y = @pos_y + @speed
        bw = @game.bottom_wall
        next_y = bw - @height if next_y + @height > bw
        delta = next_y - @pos_y
        @pos_y = next_y
        @caught_balls.each { |ball| ball.pos_y += delta }
      end

      # Detects collision with the ball. If it happens
      # bounces ball back to the game.
      def ball_collision(ball)
        angle = ball.angle
        if 90 < angle && angle < 270
          # detect bounce from the right side
          ball_right_collision(ball)
        elsif angle < 90 || angle > 270
          # detect bounce from the left side
          ball_left_collision(ball)
        end
      end

      # Freeze the ball end chain its movement with the paddle's movement.
      def catch_ball(ball)
        ball.freeze_to(self)
        @caught_balls << ball
      end

      # This method is invoked by ball when its freeze times out.
      def release_ball(ball)
        @caught_balls.delete(ball)
      end

      def release_all_balls
        @caught_balls.each(&:release_ball)
      end

      # Generates a new ball lying on the paddle.
      def create_new_ball
        ball_x = @left_paddle ? x + BALL_RADIUS : x - BALL_RADIUS
        ball_y = y + height / 2
        ball_angle = rand(0..7) * 10 - 35
        ball_angle += 180 unless @left_paddle
        ball = Ball.new(@game, ball_x, ball_y, ball_angle)
        catch_ball(ball)
        ball
      end

      private

      # Detects collision of ball to the paddle from the right side.
      def ball_right_collision(ball)
        return unless @left_paddle
        return if @pos_x > ball.x # ball is already behind the paddle
        col = collision_y_point(ball)
        return if col.nil?
        d = col - (@pos_y + @height / 2.0)
        ball.angle = count_output_angle(ball.angle, d)
        # set angle limit
        ball.angle = 290 if ball.angle.between?(180, 290)
        ball.angle = 70 if ball.angle.between?(70, 180)
        # outbounce
        if @catchy
          ball.x = @pos_x + ball.radius
          catch_ball(ball)
        else
          delta = ball.x - ball.radius - @pos_x
          ball.x = @pos_x - delta + ball.radius if delta < 0
        end
      end

      # Detects collision of ball to the paddle from the left side.
      def ball_left_collision(ball)
        return if @left_paddle
        return if @pos_x < ball.x # ball is already behind the paddle
        col = collision_y_point(ball)
        return if col.nil?
        d = (@pos_y + @height / 2.0) - col
        ball.angle = count_output_angle(ball.angle, d)
        # set angle limit
        ball.angle = 250 if ball.angle.between?(250, 359)
        ball.angle = 110 if ball.angle.between?(0, 110)
        # outbounce
        if @catchy
          ball.x = @pos_x - ball.radius
          catch_ball(ball)
        else
          delta = @pos_x - (ball.x + ball.radius)
          ball.x = @pos_x + delta - ball.radius if delta < 0
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
        c = (ball.y**2) - (ball.radius**2) + ((@pos_x - ball.x)**2)
        discriminant = b**2 - 4 * c
        return nil if discriminant < 0 # no collision with paddle
        # it is still possible that there is no collision
        y1 = (-b + Math.sqrt(discriminant)) / 2.0
        y2 = (-b - Math.sqrt(discriminant)) / 2.0
        py1 = @pos_y
        py2 = @pos_y + @height
        if y1.between?(py1, py2) && y2.between?(py1, py2)
          # both collision points are on the paddle - return avg
          (y1 + y2) / 2
        elsif y1.between?(py1, py2) || y2.between?(py1, py2)
          # exactly one point is on the paddle
          avg = (y1 + y2) / 2
          if avg.between?(py1, py2)
            avg
          elsif avg < py1
            py1
          else
            py2
          end
        end
      end
    end
  end
end
