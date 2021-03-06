require 'gosu'
require_relative 'draw_visitor'
module Arkanoid
  module Gui
    # Represents the main Gosu window of the Arkanoid game.
    class ArkanoidWindow < Gosu::Window
      def initialize(game)
        super game.width, game.height
        self.caption = 'Arkanoid Game'
        @background_image = Gosu::Image.new(media('background.png'),
                                            tileable: true)
        @wall_top_image = Gosu::Image.new(media('wall_top.png'),
                                          tileable: true)
        @wall_bottom_image = Gosu::Image.new(media('wall_bottom.png'),
                                             tileable: true)
        @game = game
        @draw_visitor = DrawVisitor.new
      end

      def media(path)
        File.expand_path(path, (File.expand_path '../../../media',
                                                 File.dirname(__FILE__)))
      end

      def update
        # player 1 keys
        @game.paddle_left_down if Gosu.button_down?(Gosu::KB_S)
        @game.paddle_left_up if Gosu.button_down?(Gosu::KB_W)
        if Gosu.button_down?(Gosu::KB_A) || Gosu.button_down?(Gosu::KB_D)
          @game.paddle_left_release
        end
        # player 2 keys
        @game.paddle_right_down if Gosu.button_down?(Gosu::KB_DOWN)
        @game.paddle_right_up if Gosu.button_down?(Gosu::KB_UP)
        if Gosu.button_down?(Gosu::KB_RIGHT) || Gosu.button_down?(Gosu::KB_LEFT)
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

      def button_down(id)
        @game.next_map! if id == Gosu::KB_N
      end
    end
  end
end
