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
end
