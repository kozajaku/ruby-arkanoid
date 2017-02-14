require_relative 'bonus'
module Arkanoid
  module Model
    module Bonus
      class DecPaddle < AbstractBonus
        def apply_bonus!
          @paddle.speed *= 0.8
          @paddle.speed = PADDLE_MOVE_STEP * 0.3 if @paddle.speed < PADDLE_MOVE_STEP * 0.3
        end
      end
    end
  end
end