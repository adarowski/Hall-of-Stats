module PlayersHelper
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

  def position(player)
    POSITIONS[player.position]
  end

  def players_by_position(position)
    Player.of_position(position).by_rank.select("id, first_name, last_name, hall_rating")
  end
end
