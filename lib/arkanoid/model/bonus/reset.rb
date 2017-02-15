require_relative 'bonus'
module Arkanoid
  module Model
    module Bonus
      class Reset < AbstractBonus
        def apply_bonus!
          # reset catchy
          @paddle.catchy = false
          @paddle.release_all_balls
          # reset size
          curr = @paddle.height
          @paddle.height = PADDLE_SIZE
          @paddle.pos_y -= (@paddle.height - curr) / 2.0
          # reset speed
          @paddle.speed = PADDLE_MOVE_STEP
        end
      end
    end
  end
end