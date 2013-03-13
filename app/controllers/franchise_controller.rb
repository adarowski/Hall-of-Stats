class FranchiseController < ApplicationController
  def index
  end
  
  def show
    @franchise = Franchise.find(params[:id])
    @players = @franchise.players.limit(@franchise.num_displayed_players)
    @all_stars = @franchise.all_stars
    @bench = @franchise.bench
    @bullpen = @franchise.bullpen
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
        values: data.select{|d| d.franchise_id == franchise.id}.map{|d| [d.range_year.to_i, d.sum.to_f]}
      } unless data.select{|d| d.franchise_id == franchise.id}.size == 0
    end.compact
    render json: sorted_data
  end
end
