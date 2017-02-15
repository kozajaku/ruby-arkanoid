require 'spec_helper'

describe Arkanoid::Model::Ball do
  let(:game) { Arkanoid::Model::Game.new}
  subject(:struct) {described_class.new(game, 80, 50, 45)}

  it 'has set positions' do
    expect(subject.x).to eq 80
    expect(subject.pos_x).to eq 80
    expect(subject.y).to eq 50
    expect(subject.pos_y).to eq 50
  end

  it 'has correct angle' do
    expect(subject.angle).to eq 45
  end

  it 'has some radius' do
    expect(subject.radius).to be > 0
  end

  it 'has some speed' do
    expect(subject.speed).to be > 0
  end

  it 'is not frozen' do
    expect(subject.frozen_to).to be nil
  end

  it 'counts radian angle' do
    expect(subject.radian_angle).to eq Math::PI / 4.0
  end

  it 'moves' do
    x = subject.x
    y = subject.y
    subject.move
    expect(subject.x).to be > x
    expect(subject.y).to be > y
  end

  it 'can mirror angle horizontally' do
    subject.angle = 80
    subject.mirror_angle_horizontally!
    expect(subject.angle).to eq 280
    subject.angle = 120
    subject.mirror_angle_horizontally!
    expect(subject.angle).to eq 240
  end

  it 'can mirror angle vertically' do
    subject.angle = 0
    subject.mirror_angle_vertically!
    expect(subject.angle).to eq 180
    subject.angle = 45
    subject.mirror_angle_vertically!
    expect(subject.angle).to eq 135
  end

end
