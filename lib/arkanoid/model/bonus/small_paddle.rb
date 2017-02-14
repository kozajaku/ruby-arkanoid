require_relative 'bonus'
module Arkanoid
  module Model
    module Bonus
      class SmallPaddle < AbstractBonus
        def apply_bonus!
          curr = @paddle.height
          @paddle.catchy = false
          @paddle.release_all_balls
          @paddle.height -= PADDLE_SIZE * 0.2
          @paddle.height = PADDLE_SIZE * 0.4 if @paddle.height < PADDLE_SIZE * 0.4
          @paddle.pos_y -= (@paddle.height - curr) / 2.0
        end
      end
    end
  end
end