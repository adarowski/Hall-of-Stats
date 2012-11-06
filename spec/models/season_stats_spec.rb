require 'spec_helper'

describe SeasonStats do
  let(:player) { create :player }
  let!(:oh_7) { create :season_stats, player: player, year: 2007 }

  it 'should not allow duplicate years for the same player' do
    build(:season_stats, player: player, year: 2007).should_not be_valid
  end
end
