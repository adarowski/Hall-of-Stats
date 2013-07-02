require 'spec_helper'

describe PlayerFilter do
  let(:player_one) { create :player, position: 'p', hos: true, personal_hof: true, hof: false, hall_rating: 120, eligibility: 'active' }
  let(:player_two) { create :player, position: '1b', hos: false, hof: false, hall_rating: 95, eligibility: 'active' }
  let(:player_three) { create :player, position: 'c', hos: false, hof: false, hall_rating: 110, eligibility: 'upcoming' }
  let(:player_four) { create :player, position: 'p', hos: false, hof: false, hall_rating: 120, eligibility: 'active' }

  subject(:filter) { PlayerFilter }

  it { filter.filters_for(player_one).should == %w( p not-hof hos personal-hof ) }
  it { filter.filters_for(player_two).should == %w( 1b not-hof not-hos not-personal-hof active-and-close ) }
  it { filter.filters_for(player_three).should == %w( c not-hof not-hos not-personal-hof upcoming ) }
  it { filter.filters_for(player_four).should == %w( p not-hof not-hos not-personal-hof active-and-worthy ) }
end
