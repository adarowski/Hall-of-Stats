class FranchisePlayerDuration < ActiveRecord::Base
  belongs_to :player

  attr_accessible :start_year, :end_year, :player_id, :franchise_id
end
