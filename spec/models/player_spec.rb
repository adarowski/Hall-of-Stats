require 'spec_helper'

describe Player do
  describe '#name' do
    subject(:player) { build(:player, first_name: 'Babe', last_name: 'Ruth') }

    its(:name) { should == 'Babe Ruth' }
  end

  describe '#years_played' do
    describe 'for a multi-year span' do
      subject(:player) { build(:player, first_year: 1985, last_year: 1993) }
      its(:years_played) { should == '1985-1993' }
    end

    describe 'for a single year' do
      subject(:player) { build(:player, first_year: 1985, last_year: 1985) }
      its(:years_played) { should == '1985' }
    end
  end

  describe '#set_compatibility_id' do
    context "for players with periods in their id" do
      subject(:player) { create(:player, id: "ha.ha.ha", first_year: 1985, last_year: 1985) }
      its(:compatibility_id) { should == 'hahaha' }
    end

    context "for players without periods in their id" do
      subject(:player) { create(:player, id: "smurfs", first_year: 1985, last_year: 1985) }
      its(:compatibility_id) { should == 'smurfs' }
    end
  end

  describe '.most_mentioned' do
    let!(:player_1) { create(:player) }
    let!(:player_2) { create(:player) }
    let!(:unmentioned_player) { create(:player) }

    let!(:article) { create(:article, body: "I like @#{player_1.id} and @#{player_2.id}") }
    let!(:article2) { create(:article, body: "I like @#{player_2.id}") }

    it 'should list players by how many articles they are mentioned in' do
      Player.most_mentioned.map(&:id).should == [player_2, player_1].map(&:id)
    end
  end
end
