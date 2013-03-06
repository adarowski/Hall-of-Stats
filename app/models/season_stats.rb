class SeasonStats < ActiveRecord::Base
  attr_accessible :player_id, :waa_pos, :war_pos, :waa_p, :war_p, :waa_tot, :war_tot, :year,
    :team, :franchise_id, :stint, :lg, :hall_rating,
    as: :admin

  belongs_to :player
  belongs_to :franchise
end
