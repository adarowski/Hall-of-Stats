namespace :similarity do
  desc 'Generate similarity scores for players matching given criteria, based on given algorithm.'
  task :generate => :environment do
    ActiveRecord::Base.connection.execute "delete from similarity_scores"
    players = Player.all[0..10]
    players.each do |p1|
      (players - [p1]).each do |p2|
        SimilarityScore.record_similarity(p1, p2)
      end
    end
  end

  desc 'Export current similarity table to a spreadsheet.'
  task :export do
  end
end
