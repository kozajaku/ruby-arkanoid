module Arkanoid
  module Model
    module Bonus
      # Represents an abstract bonus.
      # Every concrete bonus should inherit from this class.
      class AbstractBonus
        include Constants

        attr_reader :pos_x, :pos_y
        alias x pos_x
        alias y pos_y

        def initialize(x, y, paddle)
          @pos_x = x
          @pos_y = y
          @paddle = paddle
          @disposed = false
        end

        def move
          @pos_x += BONUS_SPEED * (@paddle.left_paddle ? -1 : 1)
          if @pos_x < @paddle.x &&
             @pos_x + BONUS_SIZE > @paddle.x &&
             @pos_y > @paddle.y - BONUS_SIZE &&
             @pos_y < @paddle.y + @paddle.height
            @disposed = true
            apply_bonus!
          end
        end

        def out?
          return true if @disposed
          true if @pos_x + BONUS_SIZE < 0 || @pos_x > GAME_WIDTH
        end

        def apply_bonus!
          raise NotImplementedError
        end
      end
    end
  end
end
