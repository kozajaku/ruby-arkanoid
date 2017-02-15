require_relative 'bonus'
module Arkanoid
  module Model
    module Bonus
      # Represents a bonus where the paddle
      # is to be enlarged.
      class BigPaddle < AbstractBonus
        def apply_bonus!
          curr = @paddle.height
          @paddle.catchy = false
          @paddle.release_all_balls
          @paddle.height += PADDLE_SIZE * 0.2
          @paddle.height = PADDLE_SIZE * 3 if @paddle.height > PADDLE_SIZE * 3
          @paddle.pos_y -= (@paddle.height - curr) / 2.0
        end
      end
    end
  end
end
