class PlayersController < ApplicationController
  def index
    @players= Player.front_page.by_rank
    @articles = Article.published.by_published_at
  end

  def show
    @player = PlayerDecorator.new(Player.find(params[:id]))
  end

  def autocomplete
    render json: Player.name_like(params[:name])
  end
end
