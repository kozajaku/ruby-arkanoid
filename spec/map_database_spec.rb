require 'spec_helper'

describe Arkanoid::Model::MapDatabase do
  let(:game) { Arkanoid::Model::Game.new }
  subject(:struct) { described_class.new(game) }

  it 'sets game properly' do
    expect(subject.instance_eval { @game }).to eq game
  end

  it 'loads some maps' do
    expect(subject.instance_eval { @maps }.length).to be > 0
  end

  it 'returns next map' do
    next_map = subject.next_map
    expect(next_map).to be_an_instance_of(Arkanoid::Model::GameMap)
  end

  it 'rotates maps' do
    length = subject.instance_eval { @maps.length }
    curr = subject.instance_eval { @current_map_index }
    (1..length).each { |i| subject.next_map }
    expect(subject.instance_eval { @current_map_index }).to eq curr
  end
end