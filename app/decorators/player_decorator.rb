class PlayerDecorator < Draper::Base
  decorates :player

  delegate :name, to: :player

  POSITIONS = {
    'c' => 'Catcher',
    '1b' => 'First Baseman',
    '2b' => 'Second Baseman',
    '3b' => 'Third Baseman',
    'ss' => 'Shortstop',
    'lf' => 'Left Fielder',
    'cf' => 'Center Fielder',
    'rf' => 'Right Fielder',
    'dh' => 'Designated Hitter',
    'p' => 'Pitcher'
  }

  # don't use the helper so that we can be called from PlayerLinker
  def link
    "/player/#{id}"
  end

  def position_name
    POSITIONS[player.position]
  end

  def players_of_same_position
    Player.of_position(player.position).
      by_rank.
      in_hos.
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
    photo_path.present?
  end

  def body_classes
    classes = ['player']

    classes << 'hof' if player.hof
    classes << 'hos' if player.hos

    classes << 'photo' if has_photo?

    classes
  end
end
