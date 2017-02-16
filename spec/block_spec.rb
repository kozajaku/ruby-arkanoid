require 'spec_helper'

describe Arkanoid::Model::Block do
  let(:game) { Arkanoid::Model::Game.new }

  context 'initialization' do
    subject(:struct) { described_class.new(1, game) }

    it 'has correct type' do
      expect(subject.type).to eq 1
    end

    it 'has no position in the beginning' do
      expect(subject.x).to be nil
      expect(subject.y).to be nil
    end

    it 'has correctly set the game' do
      expect(subject.instance_eval { @game }).to eq game
    end

    it 'properly sets a position' do
      subject.set_position(25, 48)
      expect(subject.x).to eq subject.pos_x
      expect(subject.y).to eq subject.pos_y
      expect(subject.x).to eq 25
      expect(subject.y).to eq 48
    end
  end

  context 'hitting' do
    subject(:b0) {described_class.new(0, game)}
    subject(:b1) {described_class.new(1, game)}
    subject(:b2) {described_class.new(2, game)}
    subject(:b3) {described_class.new(3, game)}
    subject(:b4) {described_class.new(4, game)}
    subject(:b5) {described_class.new(5, game)}
    subject(:b6) {described_class.new(6, game)}
    subject(:b7) {described_class.new(7, game)}

    it 'none is crushed' do
      expect(b0.hit!).to eq true
    end

    it 'single life blocks are crushed' do
      expect(b1.hit!).to eq true
      expect(b6.hit!).to eq true
      expect(b7.hit!).to eq true
      expect(b1.type).to eq 0
      expect(b6.type).to eq 0
      expect(b7.type).to eq 0
    end

    it 'two life block is changed to 1 life' do
      expect(b2.hit!).to eq false
      expect(b2.type).to eq 1
    end

    it 'three life block is changed to 2 life' do
      expect(b3.hit!).to eq false
      expect(b3.type).to eq 2
    end

    it 'four life block is changed to 3 life' do
      expect(b4.hit!).to eq false
      expect(b4.type).to eq 3
    end

    it 'five life block is changed to 4 life' do
      expect(b5.hit!).to eq false
      expect(b5.type).to eq 4
    end
  end
end