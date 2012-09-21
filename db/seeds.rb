require 'csv'

Player.transaction do
  CSV.parse(File.open("hall-of-stats-new.csv"), headers: true).each do |row|
    player = row.to_hash

    player['id'] = player.delete('player_id')

    # normalize some data
    player['hos'] = true     if player['hos'].try(:strip) == 'hos'
    player['hof'] = true     if player['hof'].try(:strip) == 'hof'
    player['position'] = 'p' if player['position'] == 'rp'

    player['image_url'].delete if player['image_url'].blank?

    record = Player.find_or_initialize_by_id(player['id'])
    record.update_attributes!(player, as: :admin)
  end
end

munson = Player.find('munsoth01')
munson.bio = File.read("#{Rails.root}/spec/support/fixtures/bio.markdown").strip
munson.photo_path = 'thumbs/munsoth01.jpg'
munson.save!

if AdminUser.where(email: 'admin@example.com').blank?
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
end
