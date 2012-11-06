class SeasonStats < ActiveRecord::Base
  attr_accessible :player_id, :waa_tot, :war_tot, :year,
    as: :admin

  belongs_to :player

  validates :year, uniqueness: { scope: :player_id }
end
