def rank(column_to_update, where_clause="1=1")
  update_sql = <<-SQL
create sequence player_ranking_seq increment by 1 minvalue 1;
update players
set #{column_to_update} = p.ranking
from (select s.id, nextval('player_ranking_seq') as ranking
  from (select * from players where #{where_clause} order by hall_rating desc, id) as s
) as p
where p.id = players.id;
drop sequence player_ranking_seq;
  SQL
  Player.transaction do
    ActiveRecord::Base.connection.execute update_sql
  end
end

namespace :rankings do
  desc 'Generate overall rankings for all players, based on hall_rating'
  task :overall => :environment do
    rank('ranking_overall')
  end

  desc 'Generate per-position rankings for all players, based on hall_rating'
  task :position => :environment do
    Position.all.each do |position|
      rank('ranking_position', "position = '#{position.id}'")
    end
  end

  desc 'Generate rankings for all players in the Hall of Fame, based on hall_rating'
  task :hof => :environment do
    rank('ranking_hof', 'hof is true')

  end

  desc 'Generate rankings for all players in the Hall of Stats, based on hall_rating'
  task :hos => :environment do
    rank('ranking_hos', 'hos is true')
  end

  desc 'Generate all rankings'
  task :all => [:overall, :position, :hof, :hos]
end
