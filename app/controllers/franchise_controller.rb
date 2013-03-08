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
end
