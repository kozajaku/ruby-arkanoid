require 'spec_helper'

describe Arkanoid::Model::GameMap do
  let(:game) { Arkanoid::Model::Game.new }
  let(:visitor_stub) { Class.new do
    attr_reader :counter

    def initialize
      @counter = 0
    end

    def visit_block(block)
      @counter += 1
    end
  end.new }
  subject(:struct) { described_class.all_green(game) }

  it 'sets game properly' do
    expect(subject.instance_eval { @game }).to eq game
  end

  it 'sets height and width' do
    expect(subject.instance_eval { @height }).to be > 0
    expect(subject.instance_eval { @width }).to be > 0
  end

  it 'sets a position' do
    expect(subject.instance_eval { @pos_x }).to be >= 0
    expect(subject.instance_eval { @pos_y }).to be >= 0
  end

  it 'sets position to every block' do
    blocks = subject.instance_eval { @blocks }
    expect(blocks).not_to be nil
    blocks.each do |row|
      row.each do |block|
        expect(block.x).not_to be nil
        expect(block.y).not_to be nil
      end
    end
  end

  it 'properly applies visitor on every block' do
    subject.accept_visitor(visitor_stub)
    expect(visitor_stub.counter).to eq 270
  end
end