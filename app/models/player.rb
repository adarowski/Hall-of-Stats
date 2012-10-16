class Player < ActiveRecord::Base
  self.primary_key = :id

  # admins can do whatever they want
  attr_accessible :eligibility, :first_name, :hall_rating, :hof, :hos, :id,
    :last_name, :peak_pct, :position, :waa0_tot, :war162_tot, :wwar,
    :longevity_pct, :runs_bat, :runs_br, :runs_dp, :runs_defense,
    :runs_totalpos, :pa, :war_pos, :war162_pos, :waa_pos, :ip_outs, :war_p,
    :war162_p, :waa_p, :war_tot, :waa_tot, :bio, :first_year,
    :last_year, :runs_pitch, :img_url, :photo_path, :alt_hof,
    as: :admin

  scope :of_position, lambda{|position_abbrev|
    where(position: position_abbrev)
  }

  scope :by_rank, order("hall_rating desc")

  scope :in_hos, where(hos: true)
  scope :in_hof, where(hof: true)
  scope :not_in_hos, where(hos: false)
  scope :not_in_hof, where(hof: false)
  scope :hall_worthy, where("hall_rating > 100")

  scope :name_like, lambda {|name|
    select("concat(first_name, ' ', last_name) as full_name, id, first_year, last_year").
      where("first_name ilike :name or last_name ilike :name or concat(first_name, ' ', last_name) ilike :name", name: "#{name}%")
  }

  scope :front_page, where("hof is true or hos is true or (hos is false and hall_rating > 100)")

  has_and_belongs_to_many :articles

  def name
    [first_name, last_name].join(' ')
  end

  def years_played
    [first_year, last_year].uniq.join('-')
  end

  def hall_worthy?
    hall_rating > 100
  end

  def upcoming?
    !hos && !hof && hall_worthy?
  end

  def removed?
    !hos && hof
  end
end
