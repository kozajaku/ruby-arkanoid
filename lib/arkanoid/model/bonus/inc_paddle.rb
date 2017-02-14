require_relative 'bonus'
module Arkanoid
  module Model
    module Bonus
      class IncPaddle < AbstractBonus
        def apply_bonus!
          @paddle.speed *= 1.3
          @paddle.speed = PADDLE_MOVE_STEP * 4 if @paddle.speed > PADDLE_MOVE_STEP * 4
        end
      end
    end
  end
end