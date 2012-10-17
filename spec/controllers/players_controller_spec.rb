require 'spec_helper'

describe PlayersController do
  describe '#autocomplete' do
    before do
      create(:player, id: 'koufasa01', first_name: 'Sandy', last_name: 'Koufax')
      create(:player, id: 'freehbi01', first_name: 'Bill', last_name: 'Freehan')
      create(:player, id: 'simmote01', first_name: 'Ted', last_name: 'Simmons')
      create(:player, id: 'tenacge01', first_name: 'Gene', last_name: 'Tenace')
      create(:player, id: 'fiskca01', first_name: 'Carlton', last_name: 'Fisk', hall_rating: 110)
      create(:player, id: 'benchjo01', first_name: 'Johnny', last_name: 'Bench')
      create(:player, id: 'cartega01', first_name: 'Gary', last_name: 'Carter', hall_rating: 112)
    end

    describe 'results' do
      before :each do
        post :autocomplete, name: 'car'
        @results = ActiveSupport::JSON.decode(response.body)
      end
      it 'should be correct' do
        names = @results.map{|r| r['full_name'] }
        names.should include 'Gary Carter'
        names.should include 'Carlton Fisk'

        names.should_not include 'Sandy Koufax'
        names.should_not include 'Bill Freehan'
        names.should_not include 'Ted Simmons'
        names.should_not include 'Gene Tenace'
        names.should_not include 'Johnny Bench'
      end

      it 'should be correctly ordered' do
        ids = @results.map{|r| r['id'] }

        ids.should == %w( cartega01 fiskca01 )
      end
    end
  end
end
