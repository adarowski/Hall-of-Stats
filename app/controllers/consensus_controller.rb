class ConsensusController < ApplicationController

  def index
    @hall_of_consensus = Player.hall_of_consensus.by_rank
    @hof_hos_hom = Player.hof_hos_hom.by_rank
    @hall_of_consensus_list = Player.hall_of_consensus_list.by_rank
    @only_hof = Player.only_hof.by_rank
    @only_hos = Player.only_hos.by_rank
    @only_adam = Player.only_adam.by_rank
    @only_ross = Player.only_ross.by_rank
    @only_bryan = Player.only_bryan.by_rank
    @only_dan = Player.only_dan.by_rank
    @only_dalton = Player.only_dalton.by_rank
    @all_but_hof = Player.all_but_hof.by_rank
    @all_but_hos = Player.all_but_hos.by_rank
    @all_but_adam = Player.all_but_adam.by_rank
    @all_but_ross = Player.all_but_ross.by_rank
    @all_but_bryan = Player.all_but_bryan.by_rank
    @all_but_dan = Player.all_but_dan.by_rank
    @all_but_dalton = Player.all_but_dalton.by_rank
  end

end
