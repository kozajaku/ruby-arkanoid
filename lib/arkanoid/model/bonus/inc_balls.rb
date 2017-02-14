require_relative 'bonus'
module Arkanoid
  module Model
    module Bonus
      class IncBalls < AbstractBonus
        def apply_bonus!
          @paddle.game.balls.each do |ball|
            ball.speed *= 1.2
          end
        end
      end
    end
  end
end