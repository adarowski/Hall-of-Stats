require 'spec_helper'

describe SeasonStats do
  let(:player) { create :player }
  let(:franchise) { Franchise.first }
  let!(:oh_7) { create :season_stats, player: player, franchise: franchise, year: 2007 }

  it 'should not allow duplicate years for the same player and franchise' do
    build(:season_stats, player: player, franchise_id: franchise.id, year: 2007).should_not be_valid

    build(:season_stats, player: create(:player), franchise_id: franchise.id, year: 2007).should be_valid
    build(:season_stats, player: player, franchise_id: franchise.id, year: 2008).should be_valid
    build(:season_stats, player: player, franchise_id: Franchise.last.id, year: 2007).should be_valid
  end
end
