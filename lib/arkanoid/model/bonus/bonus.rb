require_relative '../constants'
require_relative 'abstract_bonus'
require_relative 'triple'
require_relative 'dec_balls'
require_relative 'inc_balls'
require_relative 'dec_paddle'
require_relative 'inc_paddle'
require_relative 'big_paddle'
require_relative 'small_paddle'
require_relative 'catchy'
require_relative 'random_bonus'

module Arkanoid
  module Model
    module Bonus
      # Creates random bonus running to the random side.
      def self.random_bonus(x, y, game)
        rand_paddle = game.paddles.sample
        ObjectSpace.each_object(Class).select { |klass| klass < AbstractBonus }
            .sample.new(x, y, rand_paddle)
      end
    end
  end
end