class AddFranchiseRankingsToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :franchise_rankings, :text
  end
end
