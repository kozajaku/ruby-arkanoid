require 'spec_helper'

describe Arkanoid do
  it 'has a version number' do
    expect(Arkanoid::VERSION).not_to be nil
  end

  it 'has model' do
    expect(Arkanoid::Model).not_to be nil
  end

  it 'has gui' do
    expect(Arkanoid::Gui).not_to be nil
  end

  it 'can start game' do
    expect(Arkanoid).to respond_to :show_window
  end
end
