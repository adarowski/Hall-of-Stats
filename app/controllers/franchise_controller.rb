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
end
