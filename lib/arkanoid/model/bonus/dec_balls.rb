require_relative 'bonus'
module Arkanoid
  module Model
    module Bonus
      class DecBalls < AbstractBonus
        def apply_bonus!
          @paddle.game.balls.each do |ball|
            ball.speed *= 0.8
          end
        end
      end
    end
  end
end