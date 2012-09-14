class PlayersController < ApplicationController
  def index
  end

  def show
    @player = PlayerDecorator.new(Player.find(params[:id]))
  end
end
