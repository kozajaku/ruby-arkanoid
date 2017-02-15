require_relative 'bonus'
module Arkanoid
  module Model
    module Bonus
      # Represents the bonus, where every ball in the game
      # is to be slowed.
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
