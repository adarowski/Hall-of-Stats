class NlmleController < ApplicationController

  def index
    @has_nlmle = Player.has_nlmle.by_mle_rank
  end

end
