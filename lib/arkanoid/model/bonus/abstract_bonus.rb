module Arkanoid
  module Model
    module Bonus
      class AbstractBonus
        include Constants

        attr_reader :pos_x, :pos_y
        alias_method :x, :pos_x
        alias_method :y, :pos_y

        def initialize(x, y, paddle)
          @pos_x = x
          @pos_y = y
          @paddle = paddle
          @disposed = false
        end

        def move
          if @paddle.left_paddle
            @pos_x -= BONUS_SPEED
          else
            @pos_x += BONUS_SPEED
          end
          if @pos_x < @paddle.x and @pos_x + BONUS_SIZE > @paddle.x
            if @pos_y > @paddle.y - BONUS_SIZE and @pos_y < @paddle.y + @paddle.height
              @disposed = true
              apply_bonus!
            end
          end
        end

        def is_out?
          return true if @disposed
          true if @pos_x + BONUS_SIZE < 0 or @pos_x > GAME_WIDTH
        end

        def apply_bonus!
          raise NotImplementedError
        end

      end
    end
  end
end