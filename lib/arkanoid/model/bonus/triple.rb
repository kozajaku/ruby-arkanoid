require_relative 'bonus'
module Arkanoid
  module Model
    module Bonus
      class Triple < AbstractBonus
        def apply_bonus!
          balls = @paddle.game.balls
          new_balls = []
          balls.each do |ball|
            b1 = ball.clone
            b1.angle = adjust_angle((ball.angle - 20) % 360)
            b2 = ball.clone
            b2.angle = adjust_angle((ball.angle + 20) % 360)
            new_balls << b1 << b2
          end
          new_balls.each { |b| @paddle.game.balls << b }
        end

        private

        def adjust_angle(angle)
          if angle.between?(70, 110)
            return 70 if angle < 90
            return 110 if angle >= 90
          end
          if angle.between?(250, 290)
            return 250 if angle < 270
            return 290 if angle >= 270
          end
          angle
        end
      end
    end
  end
end