require_relative 'bonus'
module Arkanoid
  module Model
    module Bonus
      # Represents the bonus where the paddle
      # should become catchy for every ball.
      class Catchy < AbstractBonus
        def apply_bonus!
          @paddle.catchy = true
          # reset size
          curr = @paddle.height
          @paddle.height = PADDLE_SIZE
          @paddle.pos_y -= (@paddle.height - curr) / 2.0
        end
      end
    end
  end
end
