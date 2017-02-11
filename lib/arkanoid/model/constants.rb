module Arkanoid
  module Model
    module Constants
      # game dimensions
      GAME_WIDTH = 500
      GAME_HEIGHT = 300

      # ball implicit constants
      BALL_RADIUS = 5 #pixels
      BALL_SPEED = 2 #pixels per move

      # wall boundaries definition
      TOP_WALL_Y = 5
      BOTTOM_WALL_Y = GAME_HEIGHT - TOP_WALL_Y

      # paddle constants definition
      PADDLE_MOVE_STEP = 5
      PADDLE_SIZE = 30
      # 70 degree bounce away when ball hits the paddle on the side under 0 degree
      PADDLE_BOUNCE_CONSTANT = 2 * Math.tan((70.0 / 2.0) / 180.0 * Math::PI)
    end
  end
end