class FranchiseController < ApplicationController
  def index
  end
  
  def show
    @franchise = Franchise.find(params[:id])
    @players = @franchise.players.limit(@franchise.num_displayed_players)
    @all_stars = @franchise.all_stars
    @bench = @franchise.bench
    @bullpen = @franchise.bullpen
    @json_data = franchise_total_data
    @all_time_team_data = franchise_all_time_team_data
  end

  def franchise_all_time_team_data
    first_year = @franchise.all_stars.map(&:first_year).min
    last_year = @franchise.all_stars.map(&:last_year).max
    sql = <<-SQL
select plyrs.id as player_id, range_year, coalesce(sum(ss.hall_rating), 0) as sum
from generate_series(#{@franchise.first_year}, #{@franchise.last_year || 2012}, 1) as range_year
cross join (
  select id from players where id in (#{@franchise.all_stars.map{|p| "'#{p.id}'"}.join(',')})
) as plyrs
left join season_stats ss
on ss.franchise_id = '#{@franchise.id}' and ss.player_id = plyrs.id and range_year = ss.year
group by range_year, plyrs.id
order by plyrs.id, range_year
    SQL
    #raise sql
    data = SeasonStats.find_by_sql(sql)
    sorted_data = @franchise.all_stars.map do |player|
      { key: player.name,
        values: data.select{|d| d.player_id == player.id}.map{|d| [d.range_year.to_i, d.sum.to_f]}
      }
    end.compact.to_json
  end

  def franchise_total_data
    sql = <<-SQL
select franchise_id, year as range_year, coalesce(sum(hall_rating), 0) as sum
from season_stats
where franchise_id = '#{@franchise.id}'
group by year,franchise_id
order by franchise_id,year
    SQL
    [{ 
      key: @franchise.name,
      color: @franchise.color || '#999999',
      values: SeasonStats.find_by_sql(sql).map{|d| [d.range_year.to_i, d.sum.to_f]}
    }].to_json
  end
  
  def render_list
    @franchise = Franchise.find(params[:id])
    @players = case params[:filter_type]
      when 'franchise'  then @franchise.players.limit(@franchise.num_displayed_players)
      when 'hof'        then @franchise.players.in_hof
      when 'hos'        then @franchise.players.in_hos
      when 'p'          then @franchise.players.of_position('p').limit(200)
      else                   @franchise.players.of_position(params[:filter_type])
    end
    render @players
  end

  def charts
  end

  def all_data
    sql = <<-SQL
select stats.franchise_id, range_year, coalesce(sum(ss.hall_rating), 0) as sum 
from generate_series(
  (select min(year) from season_stats),
  (select max(year) from season_stats),
  1) as range_year 
cross join (
  select distinct(franchise_id) from season_stats
) as stats 
left join season_stats ss 
on stats.franchise_id = ss.franchise_id and range_year = ss.year 
group by range_year, stats.franchise_id 
order by stats.franchise_id, range_year
    SQL
    data = SeasonStats.find_by_sql(sql)
    sorted_data = Franchise.active.map do |franchise|
      { key: franchise.name,
        color: franchise.color,
        values: data.select{|d| d.franchise_id == franchise.id}.map{|d| [d.range_year.to_i, d.sum.to_f]}
      } unless data.select{|d| d.franchise_id == franchise.id}.size == 0
    end.compact
    render json: sorted_data
  end
end
