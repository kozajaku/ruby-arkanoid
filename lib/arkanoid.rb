require 'arkanoid/version'
require 'arkanoid/model/game'
require 'arkanoid/gui/arkanoid_window'

module Arkanoid

  def self.show_window
    game = Model::Game.new(nil)
    Gui::ArkanoidWindow.new(game).show
  end
end

