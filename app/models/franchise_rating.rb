class FranchiseRating < ActiveRecord::Base
  attr_accessible :player_id, :franchise_id, :hall_rating,
    as: :admin

  belongs_to :player
  belongs_to :franchise
end
