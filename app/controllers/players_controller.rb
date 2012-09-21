class PlayersController < ApplicationController
  def index
    @players_in_hos = Player.in_hos.by_rank
  end

  def show
    @player = PlayerDecorator.new(Player.find(params[:id]))
  end
end
