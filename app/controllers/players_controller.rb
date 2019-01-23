class PlayersController < ApplicationController
  def index
    @players= Player.front_page.by_rank
    @articles = Article.published.by_published_at.page(1)
    @cover_model = PlayerDecorator.new(Player.cover_models.order('random()').first)
  end

  def show
    @player = PlayerDecorator.new(Player.find(params[:id]))
    @bbwaa_2020_returning = Player.bbwaa_2020_returning.where(id: params[:id]).exists?
    @voting_results = VotingResult.where(player_id: @player.id).chronological.by_vote_type
  end

  def autocomplete
    render json: Player.name_like(params[:name]).by_rank.map{|p| {full_name: p.full_name, id: p.id, years_played: p.years_played} }
  end
end
