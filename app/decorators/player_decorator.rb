# encoding: UTF-8

class PlayerDecorator < Draper::Decorator
  decorates :player

  delegate_all
  delegate :name, to: :player

  POSITIONS = {
    'c' => 'Catcher',
    '1b' => 'First Baseman',
    '2b' => 'Second Baseman',
    '3b' => 'Third Baseman',
    'ss' => 'Shortstop',
    'if' => 'Infielder',
    'of' => 'Outfielder',
    'lf' => 'Left Fielder',
    'cf' => 'Center Fielder',
    'rf' => 'Right Fielder',
    'dh' => 'Designated Hitter',
    'p' => 'Pitcher',
    'npos' => 'No Position'
  }

  ALT_HOFS = {
    'mgr' => 'Manager',
    'pioneer' => 'Pioneer/Executive',
    'ump' => 'Umpire',
    'nlbp' => 'Negro Leagues player',
    'nlbm' => 'Negro Leagues manager',
    'nlbe' => 'Negro Leagues pioneer/executive'
  }

  ERA_COMMITTEES = {
    'early_baseball' => 'Early Baseball',
    'golden_days' => 'Golden Days',
    'modern_baseball' => 'Modern Baseball',
    'todays_game' => 'Today’s Game',
    'classic_baseball' => 'Classic Baseball',
    'contemporary_baseball' => 'Contemporary Baseball'
  }

 HOF_VIAS = {
    'bbwaa' => 'BBWAA',
    'veterans' => 'Veterans Committee',
    'old timers' => 'Old Timers Committee',
    'run off' => 'Runoff Election',
    'special election' => 'Special Election',
    'golden' => 'Golden Era Committee',
    'preintegration' => "Pre-Integration Era Committee",
    'modern baseball' => "Modern Baseball Era Committee",
    'todays game' => "Today’s Game Era Committee",
    'golden days' => "Golden Days Era Committee",
    'contemporary' => "Contemporary Era Committee"
  }

  # don't use the helper so that we can be called from PlayerLinker
  def link
    "/player/#{id}"
  end

  def position_name
    POSITIONS[player.position]
  end

  def alt_hof_name
    ALT_HOFS[player.alt_hof]
  end

  def era_committee_name
    ERA_COMMITTEES[player.era_committee]
  end

  def hof_via_name
    HOF_VIAS[player.hof_via]
  end

  def players_of_same_position
    Player.of_position(player.position).
      by_rank.
      in_hos.
      select("id, first_name, last_name, hall_rating")
  end

  def players_added
    Player.not_in_hof.
      in_hos.
      by_rank.
      select("id, first_name, last_name, hall_rating")
  end

  def players_removed
    Player.in_hof.
      not_in_hos.
      by_rank.
      select("id, first_name, last_name, hall_rating")
  end

  def players_upcoming
    Player.not_in_hof.
      not_in_hos.
      hall_worthy.
      by_rank.
      select("id, first_name, last_name, hall_rating")
  end

  def runs_x
    [
      runs_bat,
      runs_br,
      runs_defense,
      runs_dp,
      runs_pitch,
      runs_totalpos,
      0
    ].compact
  end

  def possessive_name
    if name.ends_with?('s')
      name + "'"
    else
      name + "'s"
    end
  end

  def view_player_text
    "View #{possessive_name} page"
  end

  def has_photo?
    img_url.present?
  end

  def body_classes
    classes = ['player']

    classes << 'hof' if player.hof
    classes << 'hos' if player.hos

    classes << 'photo' if has_photo?

    classes
  end

  def sorted_season_stats
    years = season_stats.map(&:year).uniq
    years.inject({}) do |hsh, y|
      hsh[y] = season_stats.where(year: y).order('stint asc')
      hsh
    end
  end

  def season_stat_totals_for_styling
    season_stats.inject({}) do |hsh, ss|
      hsh[ss.year] ||= {war: 0, waa: 0}
      hsh[ss.year][:war] += ss.war_tot
      hsh[ss.year][:waa] += ss.waa_tot
      hsh
    end
  end

  def keywords
    [
      player.name,
      "#{player.name} stats",
      position_name,
      ("Hall of Fame" if player.hof),
      ("Hall of Stats" if player.hos),
      "Sabermetrics"
    ].compact.join(",")
  end
end
