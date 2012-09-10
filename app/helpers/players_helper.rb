module PlayersHelper
  POSITIONS = {
    'c' => 'Catcher'
  }

  def position(player)
    POSITIONS[player.position] || "Don't yet have a lookup for #{player.position}"
  end
end
