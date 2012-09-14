class PlayerDecorator < Draper::Base
  decorates :player

  POSITIONS = {
    'c' => 'Catcher',
    '1b' => 'First Base',
    '2b' => 'Second Base',
    '3b' => 'Third Base',
    'ss' => 'Shortstop',
    'lf' => 'Left Field',
    'cf' => 'Center Field',
    'rf' => 'Right Field',
    'dh' => 'Designated Hitter',
    'p' => 'Pitcher'
  }

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
end
