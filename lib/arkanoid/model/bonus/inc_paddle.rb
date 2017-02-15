require_relative 'bonus'
module Arkanoid
  module Model
    module Bonus
      # This class represents bonus that should make the paddle faster.
      class IncPaddle < AbstractBonus
        def apply_bonus!
          @paddle.speed *= 1.3
          max = PADDLE_MOVE_STEP * 4
          @paddle.speed = max if @paddle.speed > max
        end
      end
    end
  end
end
