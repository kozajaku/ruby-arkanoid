require 'arkanoid/version'
require 'arkanoid/model/game'

module Arkanoid
  def self.start_game
    game = Model::Game.new(nil)
    (1..1000).each do |i|
      game.tick
      sleep(0.025)
    end
  end
end

Arkanoid.start_game