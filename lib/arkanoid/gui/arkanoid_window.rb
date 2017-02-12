require 'gosu'
require_relative 'draw_visitor'
module Arkanoid
  module Gui
    class ArkanoidWindow < Gosu::Window
      def initialize(game)
        super game.width, game.height
        self.caption = 'Arkanoid Game'
        @background_image = Gosu::Image.new('media/background.png', :tileable => true)
        @wall_top_image = Gosu::Image.new('media/wall_top.png', :tileable => true)
        @wall_bottom_image = Gosu::Image.new('media/wall_bottom.png', :tileable => true)
        @game = game
        @draw_visitor = DrawVisitor.new
      end

      def update
        # player 1 keys
        if Gosu.button_down? Gosu::KB_S
          @game.paddle_left_down
        end
        if Gosu.button_down? Gosu::KB_W
          @game.paddle_left_up
        end
        if Gosu.button_down? Gosu::KB_A or Gosu.button_down? Gosu::KB_D
          @game.paddle_left_release
        end
        # player 2 keys
        if Gosu.button_down? Gosu::KB_DOWN
          @game.paddle_right_down
        end
        if Gosu.button_down? Gosu::KB_UP
          @game.paddle_right_up
        end
        if Gosu.button_down? Gosu::KB_RIGHT or Gosu.button_down? Gosu::KB_LEFT
          @game.paddle_right_release
        end
        @game.tick
      end

      def draw
        # draw background first
        @background_image.draw(0, 0, 0)
        # draw walls
        @wall_top_image.draw(0, 0, 1)
        @wall_bottom_image.draw(0, @game.height - @wall_bottom_image.height, 1)
        @game.accept_visitor(@draw_visitor)
      end

      def needs_cursor?
        true
      end
    end
  end
end