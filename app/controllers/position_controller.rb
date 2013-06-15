class PositionController < ApplicationController
  DO_NOT_LOAD = %w( if of npos )
  N_BEST_SEASONS = 10

  def show
    redirect_to root_path if DO_NOT_LOAD.include?(params[:id])

    @position = params[:id]
    @position_name = PlayerDecorator::POSITIONS[@position]
    @players = Player.of_position(@position).by_rank.limit(Position.find(@position).num_displayed_players)
    @best_not_included = Player.of_position(@position).not_in_hos.where(eligibility: 'eligible').by_rank.limit(5)
    @best_not_inducted = Player.of_position(@position).not_in_hof.where(eligibility: 'eligible').by_rank.limit(5)
    @best_active = Player.of_position(@position).where(eligibility: 'active').by_rank.limit(5)
    @best_upcoming = Player.of_position(@position).where(eligibility: 'upcoming').by_rank.limit(5)
    @chart_data = nth_best_season_data(@position)
  end

  def nth_best_season_data(position)
    Player.of_position(position).by_rank.limit(10).map do |player|
      @stats = player.season_stats.order('hall_rating desc').limit(N_BEST_SEASONS).map do |season|
        [season.hall_rating, season.year]
      end
      @data = Array(0...N_BEST_SEASONS).map do |n| 
        Hash[:x, n + 1, :y, @stats[n].try(:[], 0), :year, @stats[n].try(:[], 1)]
      end
      {name: player.name, data: @data, marker: { symbol: 'circle' }}
    end
  end
end
