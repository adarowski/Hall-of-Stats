class PlayerDecorator < Draper::Base
  decorates :player

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
    %(<a href="/player/#{id}">#{name}</a>)
  end

  def name
    [first_name, last_name].join(' ')
  end

  def position_name
    POSITIONS[player.position]
  end

  def players_of_same_position
    Player.of_position(player.position).
      by_rank.
      in_hos.
      select("id, CONCAT_WS(' ', first_name, last_name) as name, hall_rating")
  end

  def runs_x
    [ runs_bat, runs_br, runs_dp, runs_defense, runs_totalpos, 0]
  end
end
