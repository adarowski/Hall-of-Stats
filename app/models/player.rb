class Player < ActiveRecord::Base
  self.primary_key = :id

  # admins can do whatever they want
  attr_accessible :eligibility, :first_name, :nickname, :hall_rating, :hof, :hos, :hom, :id,
    :last_name, :peak_pct, :position, :waa0_tot, :war162_tot, :wwar,
    :longevity_pct, :runs_bat, :runs_br, :runs_dp, :runs_defense,
    :runs_totalpos, :pa, :war_pos, :war162_pos, :waa_pos, :ip_outs, :war_p,
    :war162_p, :waa_p, :war_tot, :waa_tot, :bio, :first_year, :last_year, :runs_pitch,
    :img_url, :alt_hof, :hof_via, :hof_year, :personal_hof, :ross_hof, :dan_hof, :dalton_hof,
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
      where("first_name ilike :name or last_name ilike :name or concat(first_name, ' ', last_name) ilike :name or nickname ilike :name", name: "%#{name}%")
  }

  scope :front_page, where(%(
    consensus > 0 or (hos is false and hall_rating > 100)
    -- near miss
    or (hos is false and eligibility != 'active' and hall_rating >= 90 AND hall_rating <= 100.0)
    -- active and close
    or (hos is false and eligibility = 'active' and hall_rating >= 75 AND hall_rating <= 100.0)
    -- upcoming ballots
    or (hos is false and eligibility = 'upcoming' and hall_rating >= 20 and last_year >= 2008)
  ))

  scope :hall_of_consensus, in_hof.where("consensus = 8")
  scope :hof_hos_hom, in_hof.in_hos.in_hom

  scope :hall_of_consensus_list, where("consensus > 0")

  scope :cover_models, where('cover_model is true')

  scope :hall_rating_above, lambda {|rating|
    where("hall_rating > :rating", rating: rating)
  }

  scope :added, not_in_hof.in_hos
  scope :removed, in_hof.not_in_hos
  scope :upcoming, not_in_hof.not_in_hos.hall_worthy.where("eligibility = 'upcoming'")
  scope :eligible_2017, not_in_hos.where("eligibility = 'upcoming' AND hall_rating >= 20 AND last_year = 2011")
  scope :eligible_2018, not_in_hos.where("eligibility = 'upcoming' AND hall_rating >= 20 AND last_year = 2012")
  scope :eligible_2019, not_in_hos.where("eligibility = 'upcoming' AND hall_rating >= 20 AND last_year = 2013")
  scope :eligible_2020, not_in_hos.where("eligibility = 'upcoming' AND hall_rating >= 20 AND last_year = 2014")
  scope :eligible_2021, not_in_hos.where("eligibility = 'upcoming' AND hall_rating >= 20 AND last_year = 2015")
  scope :active_and_worthy, not_in_hos.hall_worthy.where("eligibility = 'active'")
  scope :active_and_close, not_in_hos.where("eligibility = 'active' AND hall_rating >= 75 AND hall_rating <= 100.0")
  scope :near_misses, not_in_hos.where("eligibility != 'active' AND hall_rating >= 90 AND hall_rating <= 100.0")

  scope :all_but_hof, not_in_hof.where("consensus = 7")
  scope :all_but_hos, not_in_hos.where("consensus = 7")
  scope :all_but_adam, not_in_personal_hof.where("consensus = 7")
  scope :all_but_ross, not_in_ross_hof.where("consensus = 7")
  scope :all_but_bryan, not_in_bryan_hof.where("consensus = 7")
  scope :all_but_dan, not_in_dan_hof.where("consensus = 7")
  scope :all_but_dalton, not_in_dalton_hof.where("consensus = 7")
  scope :only_hof, in_hof.where("consensus = 1")
  scope :only_hos, in_hos.where("consensus = 1")
  scope :only_hom, in_hom.where("consensus = 1")
  scope :only_adam, in_personal_hof.where("consensus = 1")
  scope :only_ross, in_ross_hof.where("consensus = 1")
  scope :only_bryan, in_bryan_hof.where("consensus = 1")
  scope :only_dan, in_dan_hof.where("consensus = 1")
  scope :only_dalton, in_dalton_hof.where("consensus = 1")

  scope :all_but_adam_personal, not_in_personal_hof.in_ross_hof.in_bryan_hof.in_dalton_hof.in_dan_hof
  scope :all_but_ross_personal, in_personal_hof.not_in_ross_hof.in_bryan_hof.in_dalton_hof.in_dan_hof
  scope :all_but_bryan_personal, in_personal_hof.in_ross_hof.not_in_bryan_hof.in_dalton_hof.in_dan_hof
  scope :all_but_dalton_personal, in_personal_hof.in_ross_hof.in_bryan_hof.not_in_dalton_hof.in_dan_hof
  scope :all_but_dan_personal, in_personal_hof.in_ross_hof.in_bryan_hof.in_dalton_hof.not_in_dan_hof
  scope :only_adam_personal, in_personal_hof.not_in_ross_hof.not_in_bryan_hof.not_in_dalton_hof.not_in_dan_hof
  scope :only_ross_personal, not_in_personal_hof.in_ross_hof.not_in_bryan_hof.not_in_dalton_hof.not_in_dan_hof
  scope :only_bryan_personal, not_in_personal_hof.not_in_ross_hof.in_bryan_hof.not_in_dalton_hof.not_in_dan_hof
  scope :only_dalton_personal, not_in_personal_hof.not_in_ross_hof.not_in_bryan_hof.in_dalton_hof.not_in_dan_hof
  scope :only_dan_personal, not_in_personal_hof.not_in_ross_hof.not_in_bryan_hof.not_in_dalton_hof.in_dan_hof

  scope :adam_and_hof, in_personal_hof.in_hof
  scope :adam_and_hos, in_personal_hof.in_hos
  scope :adam_and_hom, in_personal_hof.in_hom

  scope :endorsements, not_in_hof.in_personal_hof

  scope :bbwaa_2017_returning, not_in_hof.where("
    id = 'bondsba01' or
    id = 'clemero02' or
    id = 'schilcu01' or
    id = 'bagweje01' or
    id = 'mussimi01' or
    id = 'walkela01' or
    id = 'piazzmi01' or
    id = 'martied01' or
    id = 'raineti01' or
    id = 'sosasa01' or
    id = 'sheffga01' or
    id = 'kentje01' or
    id = 'mcgrifr01' or
    id = 'smithle02'
  ")
  scope :tg_era_2017, not_in_hof.where("
    id = 'mcgwima01' or
    id = 'saberbr01' or
    id = 'clarkwi02' or
    id = 'hershor01' or
    id = 'violafr01' or
    id = 'dykstle01' or
    id = 'butlebr01' or
    id = 'martide01' or
    id = 'keyji01  ' or
    id = 'darwida01' or
    id = 'strawda01' or
    id = 'phillto02' or
    id = 'langsma01' or
    id = 'candito01' or
    id = 'hershor01' or
    id = 'clarkwi02' or
    id = 'whitede03' or
    id = 'fernato01'
  ")
  scope :mb_era_2018, not_in_hof.where("
    id = 'woodwi01' or
    id = 'lolicmi01' or
    id = 'whitero01' or
    id = 'munsoth01' or
    id = 'bandosa01' or
    id = 'bondsbo01' or
    id = 'tiantlu01' or
    id = 'smithre06' or
    id = 'kaatji01' or
    id = 'campabe01' or
    id = 'tenacge01' or
    id = 'koosmje01' or
    id = 'rogerst01' or
    id = 'harrato01' or
    id = 'fostege01' or
    id = 'bluevi01' or
    id = 'grichbo01' or
    id = 'cedence01' or
    id = 'porteda02' or
    id = 'ceyro01' or
    id = 'decindo01' or
    id = 'nettlgr01' or
    id = 'simmote01' or
    id = 'cruzjo01' or
    id = 'guidrro01' or
    id = 'johnto01' or
    id = 'evansda01' or
    id = 'bellbu01' or
    id = 'sundbji01' or
    id = 'hernake01' or
    id = 'lynnfr01' or
    id = 'lemonch01' or
    id = 'reuscri01' or
    id = 'evansdw01' or
    id = 'parkeda01' or
    id = 'downibr01' or
    id = 'randowi01' or
    id = 'clarkja01' or
    id = 'barfije01' or
    id = 'tananfr01' or
    id = 'candejo01' or
    id = 'murphda05' or
    id = 'wilsowi02' or
    id = 'morrija02' or
    id = 'welchbo01' or
    id = 'whitalo01' or
    id = 'parrila02' or
    id = 'mattido01' or
    id = 'trammal01' or
    id = 'stiebda01' or
    id = 'goodedw01'
  ")
  scope :tg_era_2019, not_in_hof.where("
    id = 'rijojo01' or
    id = 'finlech01' or
    id = 'knoblch01' or
    id = 'coneda01' or
    id = 'willima04' or
    id = 'gracema01'
  ")
  scope :mb_era_2020, not_in_hof.where("
    id = 'raineti01'
  ")
  scope :gd_era_2021, not_in_hof.where("
    id = 'dicksmu01' or
    id = 'mcdougi01' or
    id = 'garvene01' or
    id = 'hodgegi01' or
    id = 'piercbi02' or
    id = 'jacksla01' or
    id = 'colavro01' or
    id = 'boyerke01' or
    id = 'pascuca02' or
    id = 'pappami01' or
    id = 'cashno01' or
    id = 'pinsova01' or
    id = 'mcdowsa01' or
    id = 'freehbi01' or
    id = 'olivato01' or
    id = 'wynnji01' or
    id = 'allendi01' or
    id = 'fregoji01' or
    id = 'daviswi02' or
    id = 'minosmi01'
  ")
  scope :eb_era_2021, not_in_hof.where("
    id = 'barnero01' or
    id = 'bondto01' or
    id = 'startjo01' or
    id = 'mathebo01' or
    id = 'mccorji01' or
    id = 'willine01' or
    id = 'whitnji01' or
    id = 'hinespa01' or
    id = 'richaha01' or
    id = 'gorege01' or
    id = 'buffich01' or
    id = 'bennech01' or
    id = 'stoveha01' or
    id = 'carutbo01' or
    id = 'mullato01' or
    id = 'brownpe01' or
    id = 'glassja01' or
    id = 'kingsi01' or
    id = 'tiernmi01' or
    id = 'stiveja01' or
    id = 'smithel01' or
    id = 'childcu01' or
    id = 'breitte01' or
    id = 'hahnno01' or
    id = 'crossla01' or
    id = 'orthal01' or
    id = 'leevesa01' or
    id = 'dahlebi01' or
    id = 'tanneje01' or
    id = 'powelja01' or
    id = 'seymocy01' or
    id = 'sheckji01' or
    id = 'whitedo01' or
    id = 'ruckena01' or
    id = 'leachto01' or
    id = 'mageesh01' or
    id = 'doylela01' or
    id = 'koneted01' or
    id = 'vaughhi01' or
    id = 'fletcar01' or
    id = 'gardnla01' or
    id = 'veachbo01' or
    id = 'adamsba01' or
    id = 'coopewi01' or
    id = 'grohhe01' or
    id = 'fournja01' or
    id = 'shawkbo01' or
    id = 'shockur01' or
    id = 'willike01' or
    id = 'maysca01' or
    id = 'schanwa01' or
    id = 'rommeed01' or
    id = 'quinnja01' or
    id = 'luquedo01' or
    id = 'uhlege01' or
    id = 'bergewa01' or
    id = 'myerbu01' or
    id = 'ferrewe01' or
    id = 'frencla01' or
    id = 'warnelo01' or
    id = 'johnsbo01' or
    id = 'camildo01' or
    id = 'bridgto01' or
    id = 'hardeme01' or
    id = 'hackst01' or
    id = 'passecl01' or
    id = 'waltebu01' or
    id = 'kellech01' or
    id = 'newsobo01' or
    id = 'leonadu02' or
    id = 'elliobo01' or
    id = 'brechha01' or
    id = 'stephve01' or
    id = 'troutdi01' or
    id = 'truckvi01'
  ")
  scope :tg_era_2022, not_in_hof.where("
    id = 'mcgrifr01' or
    id = 'martied01' or
    id = 'burksel01' or
    id = 'venturo01' or
    id = 'appieke01' or
    id = 'palmera01' or
    id = 'brownke01' or
    id = 'leiteal01' or
    id = 'walkela01' or
    id = 'olerujo01' or
    id = 'bagweje01' or
    id = 'willibe02' or
    id = 'radkebr01'
  ")
  scope :tg_era_2024, not_in_hof.where("
    id = 'clemero02' or
    id = 'bondsba01' or
    id = 'wellsda01' or
    id = 'schilcu01' or
    id = 'sosasa01' or
    id = 'finlest01' or
    id = 'loftoke01' or
    id = 'rogerke01' or
    id = 'gonzalu01' or
    id = 'mussimi01' or
    id = 'kentje01'
  ")
  scope :tg_era_2027, not_in_hof.where("
    id = 'sheffga01' or
    id = 'delgaca01' or
    id = 'gilesbr02' or
    id = 'garcino01' or
    id = 'edmonji01' or
    id = 'kendaja01' or
    id = 'vazquja01' or
    id = 'rodriiv01' or
    id = 'ramirma02' or
    id = 'posadjo01' or
    id = 'guerrvl01' or
    id = 'drewj.01' or
    id = 'camermi01'
  ")
  scope :bbwaa_2017_new, eligible_2017.where("hall_rating > 75")
  scope :bbwaa_2018_new, eligible_2018.where("hall_rating > 75")
  scope :bbwaa_2019_new, eligible_2019.where("hall_rating > 75")
  scope :bbwaa_2020_new, eligible_2020.where("hall_rating > 75")
  scope :bbwaa_2021_new, eligible_2021.where("hall_rating > 75")

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
