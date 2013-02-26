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
  CSV.parse(File.open('public/bos-hall-rating.csv'), headers: true).each do |row|
    # FIXME 2/26/13: update CSV to include franchise_id field
    stats = row.to_hash.merge(franchise_id: 'bos')
    record = FranchiseRating.new
    record.update_attributes!(stats, as: :admin)
  end
end

if AdminUser.where(email: 'admin@example.com').blank?
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
end
