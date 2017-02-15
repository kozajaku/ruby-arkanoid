require 'spec_helper'

describe Arkanoid::Model::Paddle do
  let(:game) { Arkanoid::Model::Game.new}
  subject(:struct) {game.paddles[0]}

  it 'has set position' do
    expect(subject.x).to be >= 0
    expect(subject.x).to eq subject.pos_x
    expect(subject.y).to be >= 0
    expect(subject.y).to eq subject.pos_y
  end

  it 'has some height' do
    expect(subject.height).to be > 0
  end

  it 'is not catchy' do
    expect(subject.catchy).to be false
  end

  it 'should have caught one ball' do
    expect(subject.instance_eval{ @caught_balls }.length)
        .to eq 1
  end

  it 'should move up' do
    x = subject.x
    y = subject.y
    subject.move_up
    expect(subject.x).to eq x
    expect(subject.y).to be < y
  end

  it 'should move down' do
    x = subject.x
    y = subject.y
    subject.move_down
    expect(subject.x).to eq x
    expect(subject.y).to be > y
  end

  it 'releases and catches ball' do
    ball = subject.instance_eval{ @caught_balls[0] }
    subject.release_all_balls
    expect(subject.instance_eval{ @caught_balls }.length)
        .to eq 0
    subject.catch_ball ball
    expect(subject.instance_eval{ @caught_balls }.length)
        .to eq 1
  end

  it 'creates a new ball' do
    subject.release_all_balls
    expect(subject.instance_eval{ @caught_balls }.length)
        .to eq 0
    ball = subject.create_new_ball
    expect(subject.instance_eval{ @caught_balls }.length)
        .to eq 1
    expect(ball.frozen_to).to eq subject
  end
end