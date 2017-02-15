require_relative 'game_map'
require_relative 'constants'
require_relative 'block'

module Arkanoid
  module Model
    class MapDatabase
      include Constants

      def initialize(game)
        @game = game
        @maps = []
        map_files.each { |file| @maps << construct_map(file) }
        @current_map_index = 0
      end

      def next_map
        res = @maps[@current_map_index].clone
        @current_map_index += 1
        @current_map_index %= @maps.length
        GameMap.new(@game, res)
      end

      private

      def map_dir(file='.')
        File.expand_path(file, File.expand_path('../../../maps', File.dirname(__FILE__)))
      end

      def map_files
        Dir.entries(map_dir).sort.map { |file| map_dir file }.select { |file| File.file?(file) }
      end

      def construct_map(file)
        map = []
        File.foreach(file) do |line|
          map << line.split('').map(&:to_i).collect do |type|
            if type == BlockType::NONE
              nil
            else
              Block.new(type, @game)
            end
          end
        end
        map
      end
    end
  end
end