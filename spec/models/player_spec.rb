require 'spec_helper'

describe Player do
  describe '#name' do
    subject(:player) { build(:player, first_name: 'Babe', last_name: 'Ruth') }

    its(:name) { should == 'Babe Ruth' }
  end
end
