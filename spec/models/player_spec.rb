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
end
