require_relative 'constants'

module Arkanoid
  module Model
    class Block
      include Constants

      attr_reader :type
      attr_reader :pos_x, :pos_y
      alias_method :x, :pos_x
      alias_method :y, :pos_y

      def initialize(type)
        @type = type
        @pos_x = nil
        @pos_y = nil
      end

      # This method is called by the GameMap when it finds out the final block position.
      # This action must be done before the first drawing attempt.
      def set_position(x, y)
        @pos_x = x
        @pos_y = y
      end

      # This method is called when ball hits the block.
      # Returns true if the block is crushed. False otherwise.
      def hit!
        #state machine implementation
        @type = case @type
                  when BlockType::BLACK
                    BlockType::GRAY
                  when BlockType::GRAY
                    BlockType::RED
                  when BlockType::RED
                    BlockType::ORANGE
                  when BlockType::ORANGE
                    BlockType::YELLOW
                  else
                    BlockType::NONE
                end
        @type == BlockType::NONE ? true : false
      end

      # Detects collision with ball. Adjusts ball's angle if
      # it really hit the wall. This method is called
      # when the ball really runs toward this block.
      # Direction parameter species the direction
      # the ball is coming towards the block (:v, :h, :d)
      # Returns true if the block was crushed,
      # false otherwise.
      def ball_collision(ball, direction)
        if direction == :v
          if ball.y < @pos_y and ball.y + ball.radius >= @pos_y
            top_wall_collide(ball)
            return hit!
          elsif ball.y > @pos_y + BLOCK_SIZE and ball.y - ball.radius <= @pos_y + BLOCK_SIZE
            bottom_wall_collide(ball)
            return hit!
          end
        elsif direction == :h
          if ball.x < @pos_x and ball.x + ball.radius >= @pos_x
            left_wall_collide(ball)
            return hit!
          elsif ball.x > @pos_x + BLOCK_SIZE and ball.x - ball.radius <= @pos_x + BLOCK_SIZE
            right_wall_collide(ball)
            return hit!
          end
        elsif direction == :d
          [@pos_x, @pos_x + BLOCK_SIZE].product([@pos_y, @pos_y + BLOCK_SIZE]).each do |x, y|
            if Math.hypot(ball.x - x, ball.y - y) <= ball.radius
              # possibly set bounce
              ball.angle = (ball.angle + 180) % 360
              return hit!
            end
          end
        end
        false
      end

      private

      def top_wall_collide(ball)
        ball.mirror_angle_horizontally!
        ball.pos_y = 2 * @pos_y - ball.y - 2 * ball.radius
      end

      def bottom_wall_collide(ball)
        ball.mirror_angle_horizontally!
        ball.pos_y = 2 * (@pos_y + BLOCK_SIZE) - ball.y + 2 * ball.radius
      end

      def left_wall_collide(ball)
        ball.mirror_angle_vertically!
        ball.pos_x = 2 * @pos_x - ball.x - 2 * ball.radius
      end

      def right_wall_collide(ball)
        ball.mirror_angle_vertically!
        ball.pos_x = 2 * (@pos_x + BLOCK_SIZE) - ball.x + 2 * ball.radius
      end
    end
  end
end