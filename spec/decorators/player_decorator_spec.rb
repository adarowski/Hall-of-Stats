require 'spec_helper'

describe PlayerDecorator do
  describe '#position_name' do
    it "converts the abbreviated position to words" do
      PlayerDecorator.new(mock(position: 'c')).position_name.should == 'Catcher'
      PlayerDecorator.new(mock(position: '2b')).position_name.should == 'Second Baseman'
    end
  end

  describe '#players_of_same_position' do
    let!(:catchers)   { ranked_players_for_position('c') }
    let!(:shortstops) { ranked_players_for_position('ss') }

    let(:players_of_same_position_ss) { PlayerDecorator.new(shortstops.sample).players_of_same_position }
    let(:players_of_same_position_c)  { PlayerDecorator.new(catchers.sample).players_of_same_position }

    it "returns players of the same position" do
      players_of_same_position_ss       =~ shortstops
      players_of_same_position_c.should =~ catchers
    end

    it "returns players by descending rank" do
      players_of_same_position_ss.map(&:hall_rating).should == [3,2,1]
      players_of_same_position_c.map(&:hall_rating).should  == [3,2,1]
    end
  end

  def ranked_players_for_position(position)
    3.times.map do |i|
      create(:player, hos: true, position: position, hall_rating: i + 1)
    end
  end
end
