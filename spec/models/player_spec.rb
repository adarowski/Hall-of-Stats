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

  describe "#similarity_to" do
    let(:player1) { create :player }
    let(:player2) { create :player }
    before do
      SimilarityScore.create(player1_id: player1.id, player2_id: player2.id, score: 3.0)
    end
    it { player1.similarity_to(player2).should == 3.0 }
    it { player2.similarity_to(player1).should == 3.0 }
  end
end
