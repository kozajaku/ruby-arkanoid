require 'spec_helper'

describe Arkanoid::Model::Game do
  subject(:struct){described_class.new}

  it 'has some width' do
    expect(subject.width).to be >= 0
  end

  it 'has some height' do
    expect(subject.height).to be >= 0
  end

  it 'has set top wall' do
    expect(subject.top_wall).not_to be nil
  end

  it 'has set bottom wall' do
    expect(subject.bottom_wall).not_to be nil
  end

  it 'has 2 paddles' do
    expect(subject.paddles.length).to eq 2
  end

  it 'has 2 balls after creation' do
    expect(subject.balls.length).to eq 2
  end

  it 'has no bonuses' do
    expect(subject.bonuses.length).to eq 0
  end

  it 'has map' do
    expect(subject.map).not_to be nil
  end

  it 'has centered paddles' do
    subject.paddles.each do |paddle|
      expect(paddle.y).to eq (subject.height / 2 - paddle.height / 2)
    end
  end

  it 'changes correctly map' do
    map = subject.map
    subject.next_map!
    expect(subject.map).not_to be eq map
  end

  it 'moves left paddle down' do
    paddle = subject.paddles[0]
    y = paddle.y
    subject.paddle_left_down
    expect(paddle.y).to be > y
  end

  it 'moves left paddle up' do
    paddle = subject.paddles[0]
    y = paddle.y
    subject.paddle_left_up
    expect(paddle.y).to be < y
  end

  it 'moves right paddle down' do
    paddle = subject.paddles[1]
    y = paddle.y
    subject.paddle_right_down
    expect(paddle.y).to be > y
  end

  it 'moves right paddle up' do
    paddle = subject.paddles[1]
    y = paddle.y
    subject.paddle_right_up
    expect(paddle.y).to be < y
  end

  it 'left paddle is set left' do
    expect(subject.paddles[0].left_paddle).to eq true
  end

  it 'right paddle is NOT set left' do
    expect(subject.paddles[1].left_paddle).to eq false
  end

  it 'replaces lost ball' do
    expect(subject.balls.length).to eq 2
    subject.ball_lost(subject.balls[0], true)
    expect(subject.balls.length).to eq 2
  end
end