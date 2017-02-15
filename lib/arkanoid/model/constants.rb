module Arkanoid
  module Model
    # Module represents all ingame preset constants.
    module Constants
      # game dimensions
      GAME_WIDTH = 1200
      GAME_HEIGHT = 798
      GAME_SPEEDUP_INTERVAL = 900

      # ball implicit constants
      BALL_RADIUS = 10 # pixels
      BALL_SPEED = 4 # pixels per move
      BALL_FROZEN_TIMEOUT = 300 # fraps

      # wall boundaries definition
      TOP_WALL_Y = 21
      BOTTOM_WALL_Y = GAME_HEIGHT - TOP_WALL_Y

      # paddle constants definition
      PADDLE_MOVE_STEP = 5
      PADDLE_SIZE = 100
      PADDLE_LEFT_X = 30
      PADDLE_RIGHT_X = GAME_WIDTH - PADDLE_LEFT_X
      # 70 degree bounce away when ball hits a paddle on the side under 0 degree
      PADDLE_BOUNCE_CONSTANT = 2 * Math.tan((70.0 / 2.0) / 180.0 * Math::PI)

      # blocks constants definition
      BLOCK_SIZE = 42
      BLOCK_MAX_ROWS = 18
      BLOCK_MAX_COLS = 15

      # This module represents all possible block types.
      module BlockType
        NONE = 0
        YELLOW = 1
        ORANGE = 2
        RED = 3
        GRAY = 4
        BLACK = 5
        BLUE = 6
        GREEN = 7

        def self.random
          rand(1..7)
        end
      end

      # bonuses constants definition
      BONUS_SIZE = BLOCK_SIZE
      BONUS_SPEED = 1
      BONUS_PROBABILITY = 0.15
    end
  end
end
