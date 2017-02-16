require_relative '../model/constants'
require_relative '../model/bonus/bonus'

module Arkanoid
  module Gui
    # This class represents the visitor pattern for each game component.
    # Its purpose is to draw every component to the Gosu window.
    class DrawVisitor
      # Loads up images for components.
      def initialize
        @ball_image = Gosu::Image.new(media('ball.png'))
        @paddle_left_image = Gosu::Image.new(media('paddle_left_s.png'))
        @paddle_right_image = Gosu::Image.new(media('paddle_right_s.png'))
        @block_images = load_block_images
        @bonus_images = load_bonus_images
      end

      def media(path)
        File.expand_path(path, (File.expand_path '../../../media',
                                                 File.dirname(__FILE__)))
      end

      def visit_ball(ball)
        @ball_image.draw_rot(ball.x, ball.y, 5, 0)
      end

      def visit_left_paddle(paddle)
        scale = paddle.height.to_f / @paddle_left_image.height
        @paddle_left_image.draw(paddle.x - @paddle_left_image.width,
                                paddle.y, 4, 1, scale)
      end

      def visit_right_paddle(paddle)
        scale = paddle.height.to_f / @paddle_right_image.height
        @paddle_right_image.draw(paddle.x, paddle.y, 4, 1, scale)
      end

      def visit_block(block)
        image = @block_images[block.type]
        image.draw(block.x, block.y, 3)
      end

      def visit_bonus(bonus)
        image = @bonus_images[bonus.class]
        image.draw(bonus.x, bonus.y, 4)
      end

      private

      def load_block_images
        blt = Model::Constants::BlockType
        {
            blt::BLACK => Gosu::Image.new(media('blocks/block_black.png')),
            blt::BLUE => Gosu::Image.new(media('blocks/block_blue.png')),
            blt::GRAY => Gosu::Image.new(media('blocks/block_gray.png')),
            blt::GREEN => Gosu::Image.new(media('blocks/block_green.png')),
            blt::ORANGE => Gosu::Image.new(media('blocks/block_orange.png')),
            blt::RED => Gosu::Image.new(media('blocks/block_red.png')),
            blt::YELLOW => Gosu::Image.new(media('blocks/block_yellow.png'))
        }.freeze
      end

      def load_bonus_images
        bt = Model::Bonus
        {
            bt::Triple => Gosu::Image.new(media('bonuses/lblue.png')),
            bt::Catchy => Gosu::Image.new(media('bonuses/green.png')),
            bt::BigPaddle => Gosu::Image.new(media('bonuses/dblue-up.png')),
            bt::SmallPaddle => Gosu::Image.new(media('bonuses/dblue-down.png')),
            bt::IncBalls => Gosu::Image.new(media('bonuses/red-up.png')),
            bt::DecBalls => Gosu::Image.new(media('bonuses/red-down.png')),
            bt::IncPaddle => Gosu::Image.new(media('bonuses/orange-up.png')),
            bt::DecPaddle => Gosu::Image.new(media('bonuses/orange-down.png')),
            bt::Reset => Gosu::Image.new(media('bonuses/gray.png')),
            bt::RandomBonus => Gosu::Image.new(media('bonuses/purple.png'))
        }.freeze
      end
    end
  end
end
