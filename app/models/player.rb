class Player < ActiveRecord::Base
  self.primary_key = :id

  # admins can do whatever they want
  attr_accessible :eligibility, :first_name, :hall_rating, :hof, :hos, :hom, :id,
    :last_name, :peak_pct, :position, :waa0_tot, :war162_tot, :wwar,
    :longevity_pct, :runs_bat, :runs_br, :runs_dp, :runs_defense,
    :runs_totalpos, :pa, :war_pos, :war162_pos, :waa_pos, :ip_outs, :war_p,
    :war162_p, :waa_p, :war_tot, :waa_tot, :bio, :first_year, :last_year, :runs_pitch,
    :img_url, :alt_hof, :personal_hof, :ross_hof, :dan_hof, :dalton_hof,
    :bryan_hof, :consensus, :cover_model, :compatibility_id, :franchise_rankings,
    as: :admin

  serialize :franchise_rankings, Hash

  scope :of_position, lambda{|position_abbrev|
    where(position: position_abbrev)
  }

  scope :for_similarity_test, where('pa > 1500 OR ip_outs > 1500')

  scope :by_rank, order("hall_rating desc")
  scope :by_consensus, order("consensus desc")

  scope :in_hos, where(hos: true)
  scope :in_hof, where(hof: true)
  scope :in_hom, where(hom: true)
  scope :in_personal_hof, where(personal_hof: true)
  scope :in_ross_hof, where(ross_hof: true)
  scope :in_bryan_hof, where(bryan_hof: true)
  scope :in_dan_hof, where(dan_hof: true)
  scope :in_dalton_hof, where(dalton_hof: true)
  scope :not_in_hos, where('hos is not true')
  scope :not_in_hof, where('hof is not true')
  scope :not_in_personal_hof, where('personal_hof is not true')
  scope :not_in_ross_hof, where('ross_hof is not true')
  scope :not_in_bryan_hof, where('bryan_hof is not true')
  scope :not_in_dan_hof, where('dan_hof is not true')
  scope :not_in_dalton_hof, where('dalton_hof is not true')
  scope :hall_worthy, where("hall_rating > 100")

  scope :name_like, lambda {|name|
    select("concat(first_name, ' ', last_name) as full_name, id, first_year, last_year").
      where("first_name ilike :name or last_name ilike :name or concat(first_name, ' ', last_name) ilike :name", name: "#{name}%")
  }

  scope :front_page, where(%(
    consensus > 0 or (hos is false and hall_rating > 100)
    -- near miss
    or (hos is false and eligibility != 'active' and hall_rating >= 90 AND hall_rating <= 100.0)
    -- active and close
    or (hos is false and eligibility = 'active' and hall_rating >= 75 AND hall_rating <= 100.0)
  ))

  scope :hall_of_consensus, in_hof.where("consensus = 7")
  scope :hof_hos_hom, in_hof.in_hos.in_hom

  scope :hall_of_consensus_list, where("consensus > 0")

  scope :cover_models, where('cover_model is true')

  scope :hall_rating_above, lambda {|rating|
    where("hall_rating > :rating", rating: rating)
  }

  scope :added, not_in_hof.in_hos
  scope :removed, in_hof.not_in_hos
  scope :upcoming, not_in_hof.not_in_hos.hall_worthy.where("eligibility = 'upcoming'")
  scope :active_and_worthy, not_in_hos.hall_worthy.where("eligibility = 'active'")
  scope :active_and_close, not_in_hos.where("eligibility = 'active' AND hall_rating >= 75 AND hall_rating <= 100.0")
  scope :near_misses, not_in_hos.where("eligibility != 'active' AND hall_rating >= 90 AND hall_rating <= 100.0")

  scope :all_but_hof, not_in_hof.where("consensus = 6")
  scope :all_but_hos, not_in_hos.where("consensus = 6")
  scope :all_but_adam, not_in_personal_hof.where("consensus = 6")
  scope :all_but_ross, not_in_ross_hof.where("consensus = 6")
  scope :all_but_bryan, not_in_bryan_hof.where("consensus = 6")
  scope :all_but_dan, not_in_dan_hof.where("consensus = 6")
  scope :all_but_dalton, not_in_dalton_hof.where("consensus = 6")
  scope :only_hof, in_hof.where("consensus = 1")
  scope :only_hos, in_hos.where("consensus = 1")
  scope :only_hom, in_hom.where("consensus = 1")
  scope :only_adam, in_personal_hof.where("consensus = 1")
  scope :only_ross, in_ross_hof.where("consensus = 1")
  scope :only_bryan, in_bryan_hof.where("consensus = 1")
  scope :only_dan, in_bryan_hof.where("consensus = 1")
  scope :only_dalton, in_bryan_hof.where("consensus = 1")

  has_and_belongs_to_many :articles
  has_many :season_stats, class_name: 'SeasonStats'
  has_many :franchise_ratings
  has_many :franchises, through: :franchise_ratings


  before_save :set_compatibility_id

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
