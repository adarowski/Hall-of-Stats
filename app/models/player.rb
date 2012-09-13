class Player < ActiveRecord::Base
  set_primary_key :id

  # admins can do whatever they want
  attr_accessible :eligibility, :first_name, :hall_rating, :hof, :hos, :id,
    :last_name, :peak_pct, :position, :waa0_tot, :war162_tot, :wwar,
    :longevity_pct, :runs_bat, :runs_br, :runs_dp, :runs_defense,
    :runs_totalpos, :pa, :war_pos, :war162_pos, :waa_pos, :ip_outs, :war_p,
    :war162_p, :waa_p, :war_tot, :waa_tot,
    as: :admin

  scope :of_position, lambda{|position_abbrev|
    where(position: position_abbrev)
  }

  scope :by_rank, order("hall_rating desc")

  def name
    [first_name, last_name].join(' ')
  end
end
