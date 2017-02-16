require 'spec_helper'

describe Arkanoid::Model::Bonus do
  let(:game) { Arkanoid::Model::Game.new }

  it 'returns random bonus' do
    (1..100).each do |i|
      bonus = described_class.random_bonus(10, 20, game)
      expect(bonus.x).to eq 10
      expect(bonus.y).to eq 20
      expect(bonus).to be_a_kind_of(described_class::AbstractBonus)
    end
  end

  context 'for left paddle' do
    let(:paddle) { game.paddles[0] }
    let(:bonus) { described_class::AbstractBonus.new(50, 60, paddle) }

    it 'moves left' do
      bonus.move
      expect(bonus.x).to be < 50
      expect(bonus.y).to eq 60
    end

    it 'applies nothing' do
      expect { bonus.apply_bonus! }.to raise_error NotImplementedError
    end

    it 'is out when moving out of a game' do
      (1..100).each { |i| bonus.move }
      expect(bonus.out?).to be true
    end
  end

  context 'for right paddle' do
    let(:paddle) { game.paddles[1] }
    let(:bonus) { described_class::AbstractBonus.new(50, 60, paddle) }

    it 'moves right' do
      bonus.move
      expect(bonus.x).to be > 50
      expect(bonus.y).to eq 60
    end

    it 'applies nothing' do
      expect { bonus.apply_bonus! }.to raise_error NotImplementedError
    end

    it 'is out when moving out of a game' do
      (1..1200).each { |i| bonus.move }
      expect(bonus.out?).to be true
    end
  end

  context 'for specific bonus' do
    let(:paddle) { game.paddles[0] }

    it 'BigPaddle increases paddle size' do
      bonus = described_class::BigPaddle.new(50, 60, paddle)
      h = paddle.height
      bonus.apply_bonus!
      expect(paddle.height).to be > h
    end

    it 'SmallPaddle decreases paddle size' do
      bonus = described_class::SmallPaddle.new(50, 60, paddle)
      h = paddle.height
      bonus.apply_bonus!
      expect(paddle.height).to be < h
    end

    it 'IncPaddle increases paddle speed' do
      bonus = described_class::IncPaddle.new(50, 60, paddle)
      s = paddle.speed
      bonus.apply_bonus!
      expect(paddle.speed).to be > s
    end

    it 'DecPaddle decreases paddle speed' do
      bonus = described_class::DecPaddle.new(50, 60, paddle)
      s = paddle.speed
      bonus.apply_bonus!
      expect(paddle.speed).to be < s
    end

    it 'IncBalls increases balls speed' do
      bonus = described_class::IncBalls.new(50, 60, paddle)
      ball_speeds = game.balls.collect(&:speed)
      bonus.apply_bonus!
      ball_speeds.zip(game.balls).each do |s, ball|
        expect(ball.speed).to be > s
      end
    end

    it 'DecBalls decreases balls speed' do
      bonus = described_class::DecBalls.new(50, 60, paddle)
      ball_speeds = game.balls.collect(&:speed)
      bonus.apply_bonus!
      ball_speeds.zip(game.balls).each do |s, ball|
        expect(ball.speed).to be < s
      end
    end

    it 'Catchy makes paddle catchy' do
      bonus = described_class::Catchy.new(50, 60, paddle)
      expect(paddle.catchy).to be false
      bonus.apply_bonus!
      expect(paddle.catchy).to be true
    end

    it 'Triple triples the balls' do
      bonus = described_class::Triple.new(50, 60, paddle)
      balls = game.balls.length
      bonus.apply_bonus!
      expect(game.balls.length).to eq balls * 3
    end
  end
end
