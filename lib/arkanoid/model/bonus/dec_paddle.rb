require_relative 'bonus'
module Arkanoid
  module Model
    module Bonus
      # This class represents bonus that should make the paddle slower.
      class DecPaddle < AbstractBonus
        def apply_bonus!
          @paddle.speed *= 0.8
          min = PADDLE_MOVE_STEP * 0.3
          @paddle.speed = min if @paddle.speed < min
        end
      end
    end
  end
end
