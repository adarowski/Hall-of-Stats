class FranchiseRating < ActiveRecord::Base
  # attr_accessible :player_id, :franchise_id, :hall_rating,
  #   as: :admin
  self.primary_key = :player_id

  belongs_to :player
  belongs_to :franchise
end
