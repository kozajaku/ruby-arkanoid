module Arkanoid
  module Model
    module Constants
      # game dimensions
      GAME_WIDTH = 1200
      GAME_HEIGHT = 800

      # ball implicit constants
      BALL_RADIUS = 10 #pixels
      BALL_SPEED = 4 #pixels per move

      # wall boundaries definition
      TOP_WALL_Y = 20
      BOTTOM_WALL_Y = GAME_HEIGHT - TOP_WALL_Y

      # paddle constants definition
      PADDLE_MOVE_STEP = 5
      PADDLE_SIZE = 100
      PADDLE_LEFT_X = 30
      PADDLE_RIGHT_X = GAME_WIDTH - PADDLE_LEFT_X
      # 70 degree bounce away when ball hits the paddle on the side under 0 degree
      PADDLE_BOUNCE_CONSTANT = 2 * Math.tan((70.0 / 2.0) / 180.0 * Math::PI)
    end
  end
end