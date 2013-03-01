require 'csv'

Player.transaction do
  CSV.parse(File.open("hall-of-stats-new.csv"), headers: true).each do |row|
    player = row.to_hash

    player['id'] = player.delete('player_id')

    # normalize some data
    player['hos'] = (player['hos'].try(:strip) == 'hos')
    player['hof'] = (player['hof'].try(:strip) == 'hof')

    player['position'] = 'p' if player['position'] == 'rp'

    player.delete('image_url') if player['image_url'].blank?

    record = Player.find_or_initialize_by_id(player['id'])
    record.update_attributes!(player, as: :admin)
  end
end

SeasonStats.transaction do
  CSV.parse(File.open('hall-of-stats-seasons.csv'), headers: true).each do |row|
    stats = row.to_hash

    record = SeasonStats.new
    record.update_attributes!(stats, as: :admin)
  end
end

FranchiseRating.transaction do
  CSV.parse(File.open('public/franchise-hall-rating.csv'), headers: true).each do |row|
    stats = row.to_hash
    stats['franchise_id'] = stats['franchise_id'].downcase
    record = FranchiseRating.where(player_id: stats['player_id'],
                                   franchise_id: stats['franchise_id']).first_or_initialize
    record.update_attributes!(stats, as: :admin)
  end
end

if AdminUser.where(email: 'admin@example.com').blank?
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
end
