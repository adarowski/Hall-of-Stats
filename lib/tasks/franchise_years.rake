namespace :generate do
  desc 'Generate franchise durations for players'
  task :franchise_durations => :environment do
    FranchisePlayerDuration.delete_all

    Player.transaction do
      record = nil

      SeasonStats.order("player_id asc, franchise_id asc, year asc").all.each do |stat|
        same_player     = record && stat.player_id == record.player_id
        same_franchise  = record && stat.franchise_id == record.franchise_id
        contiguous_year = record && stat.year == record.end_year + 1

        if same_player && same_franchise && contiguous_year
          record.end_year = stat.year
        else
          if record
            record.save!
            record = nil
          end

          record ||= FranchisePlayerDuration.new(
            player_id: stat.player_id,
            franchise_id: stat.franchise_id,
            start_year: stat.year,
            end_year: stat.year
          )
        end
      end

      record.save!
    end
  end
end
