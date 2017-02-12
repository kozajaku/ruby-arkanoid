module Arkanoid
  module Gui
    class DrawVisitor
      # Loads up images for components.
      def initialize
        @ball_image = Gosu::Image.new('media/ball.png')
        @paddle_left_image = Gosu::Image.new('media/paddle_left_s.png')
        @paddle_right_image = Gosu::Image.new('media/paddle_right_s.png')
      end

      def visit_ball(ball)
        @ball_image.draw_rot(ball.x, ball.y, 5, 0)
      end

      def visit_left_paddle(paddle)
        scale = paddle.height.to_f / @paddle_left_image.height
        @paddle_left_image.draw(paddle.x - @paddle_left_image.width, paddle.y, 4, 1, scale)
      end

      def visit_right_paddle(paddle)
        scale = paddle.height.to_f / @paddle_right_image.height
        @paddle_right_image.draw(paddle.x, paddle.y, 4, 1, scale)
      end

      def visit_block(block)

      end

      def visit_bonus(bonus)

      end
    end
  end
end