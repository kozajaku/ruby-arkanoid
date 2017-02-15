require 'spec_helper'

describe Arkanoid::Model::Block do
  let(:game) { Arkanoid::Model::Game.new }

  context 'block initialization' do
    subject(:struct) { described_class.new(1, game) }

    it 'has correct type' do
      expect(subject.type).to eq 1
    end

    it 'has correctly set the game' do
      expect(subject.instance_eval { @game }).to eq game
    end

  end
end