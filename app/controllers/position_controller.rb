class PositionController < ApplicationController
  def show
    @position = params[:id]
    @position_name = PlayerDecorator::POSITIONS[@position]
    @players = Player.of_position(@position).by_rank.limit(100)
    @best_not_inducted = Player.of_position(@position).not_in_hos.by_rank.limit(5)
    @best_active = Player.of_position(@position).where(eligibility: 'active').by_rank.limit(5)
  end
end
