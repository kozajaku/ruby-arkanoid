require_relative 'game_map'
require_relative 'constants'
require_relative 'block'

module Arkanoid
  module Model
    # The purpose of this class is to load game maps
    # from the files and serve them to the game.
    class MapDatabase
      include Constants

      def initialize(game)
        @game = game
        @maps = []
        map_files.each { |file| @maps << construct_map(file) }
        @current_map_index = 0
      end

      def next_map
        res = map_clone @maps[@current_map_index]
        @current_map_index += 1
        @current_map_index %= @maps.length
        GameMap.new(@game, res)
      end

      private

      def map_clone(map)
        map.collect do |row|
          row.collect do |block|
            if block.nil?
              nil
            else
              block.clone
            end
          end
        end
      end

      def map_dir(file = '.')
        maps = File.expand_path('../../../maps', File.dirname(__FILE__))
        File.expand_path(file, maps)
      end

      def map_files
        Dir.entries(map_dir).sort
           .map { |file| map_dir file }
           .select { |file| File.file?(file) }
      end

      def construct_map(file)
        map = []
        File.foreach(file) do |line|
          map << line.split('').map(&:to_i).collect do |type|
            type == BlockType::NONE ? nil : Block.new(type, @game)
          end
        end
        map
      end
    end
  end
end
