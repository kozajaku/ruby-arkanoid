require_relative 'bonus'
module Arkanoid
  module Model
    module Bonus
      # This bonus triggers random bonus
      # when it hits a paddle.
      class RandomBonus < AbstractBonus
        def initialize(x, y, paddle)
          super x, y, paddle
          @secret = Bonus.random_bonus(x, y, paddle.game)
        end

        def apply_bonus!
          @secret.apply_bonus!
        end
      end
    end
  end
end
