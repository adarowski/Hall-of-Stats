require 'csv'

Player.transaction do
  CSV.parse(File.open("hall-of-stats-new.csv"), headers: true).each do |row|
    player = row.to_hash

    player['id'] = player.delete('player_id')

    player['hos'] = true if player['hos'].try(:strip) == 'hos'
    player['hof'] = true if player['hof'].try(:strip) == 'hof'

    player['position'] = 'p' if player['position'] == 'rp'

    Player.create!(player, as: :admin).id
  end
end
