class Player < ActiveRecord::Base
  self.primary_key = :id

  # admins can do whatever they want
  attr_accessible :eligibility, :first_name, :hall_rating, :hof, :hos, :id,
    :last_name, :peak_pct, :position, :waa0_tot, :war162_tot, :wwar,
    :longevity_pct, :runs_bat, :runs_br, :runs_dp, :runs_defense,
    :runs_totalpos, :pa, :war_pos, :war162_pos, :waa_pos, :ip_outs, :war_p,
    :war162_p, :waa_p, :war_tot, :waa_tot, :bio, :first_year,
    :last_year, :runs_pitch, :img_url, :photo_path,
    as: :admin

  scope :of_position, lambda{|position_abbrev|
    where(position: position_abbrev)
  }

  scope :by_rank, order("hall_rating desc")

  scope :in_hos, where(hos: true)

  scope :name_like, lambda {|name|
    name = "#{name}%"
    select("concat(first_name, ' ', last_name) as full_name, id").
      where("first_name ilike ? or last_name ilike ? or concat(first_name, ' ', last_name) ilike ?",
            name, name, name)
  }

  def name
    [first_name, last_name].join(' ')
  end

  def years_played
    [first_year, last_year].uniq.join('-')
  end
end
