class Player < ActiveRecord::Base
  self.primary_key = :id

  serialize :franchise_rankings, Hash

  scope :of_position, lambda{|position_abbrev|
    where(position: position_abbrev)
  }

  scope :for_similarity_test, ->{ where('pa > 1500 OR ip_outs > 1500')}

  scope :by_rank, ->{order("hall_rating desc")}
  scope :by_consensus, ->{order("consensus desc")}

  scope :in_hos, ->{where(hos: true) }
  scope :in_hof, ->{where(hof: true) }
  scope :in_hom, ->{where(hom: true) }
  scope :in_personal_hof, ->{where(personal_hof: true) }
  scope :in_ross_hof, ->{where(ross_hof: true) }
  scope :in_bryan_hof, ->{where(bryan_hof: true) }
  scope :in_dan_hof, ->{where(dan_hof: true) }
  scope :in_dalton_hof, ->{where(dalton_hof: true) }
  scope :not_in_hos, ->{where('hos is not true') }
  scope :not_in_hof, ->{where('hof is not true') }
  scope :not_in_hom, ->{where('hom is not true') }
  scope :not_in_personal_hof, ->{where('personal_hof is not true') }
  scope :not_in_ross_hof, ->{where('ross_hof is not true') }
  scope :not_in_bryan_hof, ->{where('bryan_hof is not true') }
  scope :not_in_dan_hof, ->{where('dan_hof is not true') }
  scope :not_in_dalton_hof, ->{where('dalton_hof is not true') }
  scope :hall_worthy, ->{where("hall_rating > 100") }

  scope :name_like, lambda {|name|
    select("concat(first_name, ' ', last_name) as full_name, id, first_year, last_year").
      where("first_name ilike :name or last_name ilike :name or concat(first_name, ' ', last_name) ilike :name or nickname ilike :name", name: "%#{name}%")
  }

  scope :front_page, lambda{where(%(
    consensus > 0 or (hos is false and hall_rating > 100)
    -- near miss
    or (hos is false and eligibility != 'active' and hall_rating >= 90 AND hall_rating <= 100.0)
    -- active and close
    or (hos is false and eligibility = 'active' and hall_rating >= 75 AND hall_rating <= 100.0)
    -- upcoming ballots
    or (hos is false and eligibility = 'upcoming' and hall_rating >= 20 and last_year >= 2008)
  ))}

  scope :hall_of_consensus, lambda{in_hof.where("consensus = 8")}
  scope :hof_hos_hom, lambda{in_hof.in_hos.in_hom}

  scope :hall_of_consensus_list, lambda{where("consensus > 0")}

  scope :cover_models, lambda{where('cover_model is true')}

  scope :hall_rating_above, lambda {|rating|
    where("hall_rating > :rating", rating: rating)
  }

  scope :added, lambda{not_in_hof.in_hos}
  scope :removed, lambda{in_hof.not_in_hos}
  scope :upcoming, lambda{not_in_hof.not_in_hos.hall_worthy.where("eligibility = 'upcoming'")}
  scope :eligible_2022, lambda{not_in_hos.where("eligibility = 'upcoming' AND hall_rating >= 20 AND last_year = 2016")}
  scope :eligible_2023, lambda{not_in_hos.where("eligibility = 'upcoming' AND hall_rating >= 20 AND last_year = 2017")}
  scope :eligible_2024, lambda{not_in_hos.where("eligibility = 'upcoming' AND hall_rating >= 20 AND last_year = 2018")}
  scope :eligible_2025, lambda{not_in_hos.where("eligibility = 'upcoming' AND hall_rating >= 20 AND last_year = 2019")}
  scope :eligible_2026, lambda{not_in_hos.where("eligibility = 'upcoming' AND hall_rating >= 20 AND last_year = 2020")}
  scope :eligible_2027, lambda{not_in_hos.where("eligibility = 'upcoming' AND hall_rating >= 20 AND last_year = 2021")}
  scope :active_and_worthy, lambda{not_in_hos.hall_worthy.where("eligibility = 'active'")}
  scope :active_and_close, lambda{not_in_hos.where("eligibility = 'active' AND hall_rating >= 75 AND hall_rating <= 100.0")}
  scope :near_misses, lambda{not_in_hos.where("eligibility != 'active' AND hall_rating >= 90 AND hall_rating <= 100.0")}

  scope :all_but_hof, lambda{not_in_hof.where("consensus = 7")}
  scope :all_but_hos, lambda{not_in_hos.where("consensus = 7")}
  scope :all_but_adam, lambda{not_in_personal_hof.where("consensus = 7")}
  scope :all_but_ross, lambda{not_in_ross_hof.where("consensus = 7")}
  scope :all_but_bryan, lambda{not_in_bryan_hof.where("consensus = 7")}
  scope :all_but_dan, lambda{not_in_dan_hof.where("consensus = 7")}
  scope :all_but_dalton, lambda{not_in_dalton_hof.where("consensus = 7")}
  scope :only_hof, lambda{in_hof.where("consensus = 1")}
  scope :only_hos, lambda{in_hos.where("consensus = 1")}
  scope :only_hom, lambda{in_hom.where("consensus = 1")}
  scope :only_adam, lambda{in_personal_hof.where("consensus = 1")}
  scope :only_ross, lambda{in_ross_hof.where("consensus = 1")}
  scope :only_bryan, lambda{in_bryan_hof.where("consensus = 1")}
  scope :only_dan, lambda{in_dan_hof.where("consensus = 1")}
  scope :only_dalton, lambda{in_dalton_hof.where("consensus = 1")}

  scope :all_but_adam_personal, lambda{not_in_personal_hof.in_ross_hof.in_bryan_hof.in_dalton_hof.in_dan_hof}
  scope :all_but_ross_personal, lambda{in_personal_hof.not_in_ross_hof.in_bryan_hof.in_dalton_hof.in_dan_hof}
  scope :all_but_bryan_personal, lambda{in_personal_hof.in_ross_hof.not_in_bryan_hof.in_dalton_hof.in_dan_hof}
  scope :all_but_dalton_personal, lambda{in_personal_hof.in_ross_hof.in_bryan_hof.not_in_dalton_hof.in_dan_hof}
  scope :all_but_dan_personal, lambda{in_personal_hof.in_ross_hof.in_bryan_hof.in_dalton_hof.not_in_dan_hof}
  scope :only_adam_personal, lambda{in_personal_hof.not_in_ross_hof.not_in_bryan_hof.not_in_dalton_hof.not_in_dan_hof}
  scope :only_ross_personal, lambda{not_in_personal_hof.in_ross_hof.not_in_bryan_hof.not_in_dalton_hof.not_in_dan_hof}
  scope :only_bryan_personal, lambda{not_in_personal_hof.not_in_ross_hof.in_bryan_hof.not_in_dalton_hof.not_in_dan_hof}
  scope :only_dalton_personal, lambda{not_in_personal_hof.not_in_ross_hof.not_in_bryan_hof.in_dalton_hof.not_in_dan_hof}
  scope :only_dan_personal, lambda{not_in_personal_hof.not_in_ross_hof.not_in_bryan_hof.not_in_dalton_hof.in_dan_hof}

  scope :adam_and_hof, lambda{in_personal_hof.in_hof}
  scope :adam_and_hos, lambda{in_personal_hof.in_hos}
  scope :adam_and_hom, lambda{in_personal_hof.in_hom}

  scope :endorsements, lambda{not_in_hof.in_personal_hof}

  scope :bbwaa_2022_returning, lambda{not_in_hof.where("
    id = 'bondsba01' OR
    id = 'clemero02' OR
    id = 'schilcu01' OR
    id = 'ramirma02' OR
    id = 'sosasa01' OR
    id = 'sheffga01' OR
    id = 'kentje01' OR
    id = 'wagnebi02' OR
    id = 'vizquom01' OR
    id = 'rolensc01' OR
    id = 'jonesan01' OR
    id = 'heltoto01' OR
    id = 'pettian01' OR
    id = 'abreubo01' OR
    id = 'buehrma01' OR
    id = 'hudsoti01'
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

  def peak_pct_rounded
    peak_pct.round
  end

  def longevity_pct_rounded
    longevity_pct.round
  end

  has_and_belongs_to_many :similarity_scores, foreign_key: :player1_id
  has_and_belongs_to_many :similarity_scores, foreign_key: :player2_id

  def self.most_mentioned(limit=10)
    ids = Article.find_by_sql(["select player_id from articles_players group by player_id order by count(*) desc limit ?", limit]).map(&:player_id)
    ids.map{|id| Player.find(id)}
  end

  private

  def set_compatibility_id
    self.compatibility_id = self.id.delete('.')
  end
end
