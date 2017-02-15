require 'arkanoid/version'
require 'arkanoid/model/game'
require 'arkanoid/gui/arkanoid_window'

# This module represents the whole game namespace.
module Arkanoid
  def self.show_window
    game = Model::Game.new
    Gui::ArkanoidWindow.new(game).show
  end
end
