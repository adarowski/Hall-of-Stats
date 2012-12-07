class PositionController < ApplicationController
  def show
    @position = params[:id]
    @position_name = PlayerDecorator::POSITIONS[@position]
    @players = Player.of_position(@position).by_rank.limit(@position == 'p' ? 200 : 100)
    @best_not_included = Player.of_position(@position).not_in_hos.where(eligibility: 'eligible').by_rank.limit(5)
    @best_not_inducted = Player.of_position(@position).not_in_hof.where(eligibility: 'eligible').by_rank.limit(5)
    @best_active = Player.of_position(@position).where(eligibility: 'active').by_rank.limit(5)
    @best_upcoming = Player.of_position(@position).where(eligibility: 'upcoming').by_rank.limit(5)
  end
end
