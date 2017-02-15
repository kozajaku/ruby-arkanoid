require_relative 'bonus'
module Arkanoid
  module Model
    module Bonus
      # This class represents bonus that should make the paddle smaller.
      class SmallPaddle < AbstractBonus
        def apply_bonus!
          curr = @paddle.height
          @paddle.catchy = false
          @paddle.release_all_balls
          @paddle.height -= PADDLE_SIZE * 0.2
          min = PADDLE_SIZE * 0.4
          @paddle.height = min if @paddle.height < min
          @paddle.pos_y -= (@paddle.height - curr) / 2.0
        end
      end
    end
  end
end
