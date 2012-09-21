class PlayersController < ApplicationController
  def index
    @players_in_hos = Player.in_hos.by_rank
    @articles = Article.published.order("published_at desc")
  end

  def show
    @player = PlayerDecorator.new(Player.find(params[:id]))
  end

  def autocomplete
    render json: Player.name_like(params[:name])
  end
end
