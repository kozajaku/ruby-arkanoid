require_relative 'constants'
require_relative 'block'

module Arkanoid
  module Model
    # Represents collection of block positions in the game.
    class GameMap
      include Constants

      # Generates map fully loaded with green blocks.
      def self.all_green(game)
        blocks = Array.new(BLOCK_MAX_ROWS) { Array.new(BLOCK_MAX_COLS) }
        (0..blocks.length - 1).each do |row|
          (0..blocks[0].length - 1).each do |col|
            blocks[row][col] = Block.new(BlockType::GREEN)
          end
        end
        self.new(game, blocks)
      end

      # Generates map fully loaded with random blocks.
      def self.all_random(game)
        blocks = Array.new(BLOCK_MAX_ROWS) { Array.new(BLOCK_MAX_COLS) }
        (0..blocks.length - 1).each do |row|
          (0..blocks[0].length - 1).each do |col|
            blocks[row][col] = Block.new(BlockType.random)
          end
        end
        self.new(game, blocks)
      end

      # Initialize the game map with the game reference and 2D block array.
      # First index to it represents row, second column.
      def initialize(game, blocks)
        @game = game
        @height = blocks.length * BLOCK_SIZE
        @width = blocks[0].length * BLOCK_SIZE
        # set map position by centering blocks to the middle of game view
        @pos_x = (game.width - @width) / 2
        @pos_y = (game.height - @height) / 2
        @blocks = blocks
        store_block_positions!
      end

      # Accept generic visitor for visiting components. This could be used for example
      # for components drawing to ensure low coupling in model tier.
      def accept_visitor(visitor)
        @blocks.each do |row|
          row.each do |block|
            next if block.nil?
            visitor.visit_block(block)
          end
        end
      end

      # Detects collision of ball with blocks inside game map.
      def ball_collision(ball)
        move_x, move_y = count_move_vector(ball)
        mx, my = pixels_to_grid(ball.x, ball.y)
        xex = inside?(mx + move_x, my)
        yex = inside?(mx, my + move_y)
        if xex or yex
          if xex
            @blocks[my][mx + move_x] = nil if @blocks[my][mx + move_x].ball_collision(ball, :h)
          end
          if yex
            @blocks[my + move_y][mx] = nil if @blocks[my + move_y][mx].ball_collision(ball, :v)
          end
        else
          if inside?(mx + move_x, my + move_y)
            @blocks[my + move_y][mx + move_x] = nil if @blocks[my + move_y][mx + move_x].ball_collision(ball, :d)
          end
        end
      end

      private

      # Saves position of every single block to its representation.
      def store_block_positions!
        @blocks.each_with_index do |row, i|
          row.each_with_index do |block, j|
            next if block.nil?
            block.set_position(@pos_x + j * BLOCK_SIZE, @pos_y + i * BLOCK_SIZE)
          end
        end
      end

      # Counts ball move vector - represented as two values and reduced to 45 degrees
      def count_move_vector(ball)
        move_x = move_y = 0
        if ball.angle > 270 or ball.angle < 90
          move_x = 1
        elsif ball.angle > 90 and ball.angle < 270
          move_x = -1
        end
        if ball.angle > 0 and ball.angle < 180
          move_y = 1
        elsif ball.angle > 180
          move_y = -1
        end
        return move_x, move_y
      end

      # Converts pixel coordinates to the grid values. Can be out of range of blocks.
      # Index values are returned as column, row
      def pixels_to_grid(px, py)
        return (px - @pos_x).div(BLOCK_SIZE), (py - @pos_y).div(BLOCK_SIZE)
      end

      # Returns true if there exists block on the targeted grid coordinates.
      def inside?(col, row)
        return false if col < 0 or row < 0
        return false if row >= @blocks.length or col >= @blocks[0].length
        not @blocks[row][col].nil?
      end

    end
  end
end