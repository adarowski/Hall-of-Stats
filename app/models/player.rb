class Player < ActiveRecord::Base
  self.primary_key = :id

  serialize :franchise_rankings, Hash

  scope :not_nlb, ->{ where("eligibility <> 'nlb'") }

  scope :of_position, lambda{|position_abbrev|
    not_nlb.where(position: position_abbrev)
  }

  scope :of_mle_position, lambda{|position_abbrev|
    has_nlmle.where(position: position_abbrev)
  }

  scope :for_similarity_test, ->{ where('pa > 1500 OR ip_outs > 1500')}

  scope :by_rank, ->{order("hall_rating desc")}
  scope :by_mle_rank, ->{order("mle_rating desc")}
  scope :by_consensus, ->{order("consensus desc")}

  scope :in_hos, ->{where(hos: true) }
  scope :in_hof, ->{where(hof: true) }
  scope :in_hom, ->{where(hom: true) }
  scope :not_in_hos, ->{where('hos is not true') }
  scope :not_in_hof, ->{where('hof is not true') }
  scope :not_in_hom, ->{where('hom is not true') }
  scope :hall_worthy, ->{where("hall_rating > 100") }

  scope :name_like, lambda {|name|
    select("concat(first_name, ' ', last_name) as full_name, id, first_year, last_year").
      where("first_name ilike :name or last_name ilike :name or concat(first_name, ' ', last_name) ilike :name or nickname ilike :name", name: "%#{name}%")
  }

  scope :front_page, lambda{
    not_nlb.where(%(
    consensus > 0 or (hos is false and hall_rating > 100)
    -- near miss
    or (hos is false and eligibility != 'active' and hall_rating >= 90 AND hall_rating <= 100.0)
    -- active and close
    or (hos is false and eligibility = 'active' and hall_rating >= 75 AND hall_rating <= 100.0)
    -- upcoming ballots
    or (hos is false and eligibility = 'upcoming' and hall_rating >= 20 and last_year >= 2008)
  ))}

  scope :hof_hos_hom, lambda{not_nlb.in_hof.in_hos.in_hom}
  scope :hall_of_consensus_list, lambda{not_nlb.where("consensus > 0")}

  scope :cover_models, lambda{where('cover_model is true')}

  scope :hall_rating_above, lambda {|rating|
    where("hall_rating > :rating", rating: rating)
  }

  scope :has_nlmle, lambda{where("mle_rating > 0")}

  scope :added, lambda{not_in_hof.in_hos}
  scope :removed, lambda{in_hof.not_in_hos}
  scope :upcoming, lambda{not_in_hof.not_in_hos.hall_worthy.where("eligibility = 'upcoming'")}
  scope :eligible_2023, lambda{not_in_hos.where("eligibility = 'upcoming' AND hall_rating >= 20 AND last_year = 2017")}
  scope :eligible_2024, lambda{not_in_hos.where("eligibility = 'upcoming' AND hall_rating >= 20 AND last_year = 2018")}
  scope :eligible_2025, lambda{not_in_hos.where("eligibility = 'upcoming' AND hall_rating >= 20 AND last_year = 2019")}
  scope :eligible_2026, lambda{not_in_hos.where("eligibility = 'upcoming' AND hall_rating >= 20 AND last_year = 2020")}
  scope :eligible_2027, lambda{not_in_hos.where("eligibility = 'upcoming' AND hall_rating >= 20 AND last_year = 2021")}
  scope :active_and_worthy, lambda{not_in_hos.hall_worthy.where("eligibility = 'active'")}
  scope :active_and_close, lambda{not_in_hos.where("eligibility = 'active' AND hall_rating >= 75 AND hall_rating <= 100.0")}
  scope :near_misses, lambda{not_in_hos.where("eligibility != 'active' AND hall_rating >= 90 AND hall_rating <= 100.0")}

  scope :only_hof, lambda{in_hof.not_nlb.where("consensus = 1")}
  scope :only_hos, lambda{in_hos.not_nlb.where("consensus = 1")}
  scope :only_hom, lambda{in_hom.not_nlb.where("consensus = 1")}
  scope :hos_hom, lambda{in_hom.in_hos.not_in_hof.not_nlb}

  scope :bbwaa_2023_returning, lambda{not_in_hof.where("
    id = 'rolensc01' OR
    id = 'heltoto01' OR
    id = 'wagnebi02' OR
    id = 'jonesan01' OR
    id = 'sheffga01' OR
    id = 'rodrial01' OR
    id = 'kentje01' OR
    id = 'ramirma02' OR
    id = 'vizquom01' OR
    id = 'pettian01' OR
    id = 'rolliji01' OR
    id = 'abreubo01' OR
    id = 'buehrma01' OR
    id = 'hunteto01'
  ")}

  scope :tg_era_2023, lambda{not_in_hof.where("era_committee = 'todays_game' AND last_year <= 2007 AND hall_rating > 50")}
  scope :mb_era_2024, lambda{not_in_hof.where("era_committee = 'modern_baseball' AND hall_rating > 50")}
  scope :tg_era_2025, lambda{not_in_hof.where("era_committee = 'todays_game' AND last_year <= 2009 AND last_year >= 2008 AND hall_rating > 50")}
  scope :gd_era_2027, lambda{not_in_hof.where("era_committee = 'golden_days' AND hall_rating > 50")}
  scope :tg_era_2028, lambda{not_in_hof.where("era_committee = 'todays_game' AND last_year <= 2012 AND last_year >= 2010 AND hall_rating > 50")}
  scope :tg_era_2030, lambda{not_in_hof.where("era_committee = 'todays_game' AND last_year <= 2014 AND last_year >= 2013 AND hall_rating > 50")}
  scope :eb_era_2032, lambda{not_in_hof.where("era_committee = 'early_baseball' AND hall_rating > 50")}

  has_and_belongs_to_many :articles
  has_many :season_stats, class_name: 'SeasonStats'
  has_many :franchise_ratings
  has_many :franchises, through: :franchise_ratings

  before_save :set_compatibility_id

  def name
    [first_name, last_name].join(' ')
  end

  def years_played
    [first_year, last_year].uniq.join('–')
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

  def active_and_close?
    !hos && (eligibility == 'active') && hall_rating.between?(75, 100.0)
  end

  def near_miss?
    !hos && (eligibility != 'active') && hall_rating.between?(90, 100.0)
  end

  def hall_rating_rounded
    hall_rating.round
  end

  def mle_rating_rounded
    mle_rating.round
  end

  def peak_pct_rounded
    peak_pct.round
  end

  def longevity_pct_rounded
    longevity_pct.round
  end

  has_and_belongs_to_many :similarity_scores,
    class_name: "Player", join_table: "similarity_scores", foreign_key: :player1_id
  has_and_belongs_to_many :similarity_scores,
    class_name: "Player", join_table: "similarity_scores", foreign_key: :player2_id

  def self.most_mentioned(limit=10)
    ids = Article.find_by_sql(["select player_id from articles_players group by player_id order by count(*) desc limit ?", limit]).map(&:player_id)
    ids.map{|id| Player.find(id)}
  end

  private

  def set_compatibility_id
    self.compatibility_id = self.id.delete('.')
  end
end
