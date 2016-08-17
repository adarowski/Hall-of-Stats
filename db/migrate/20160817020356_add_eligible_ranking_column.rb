class AddEligibleRankingColumn < ActiveRecord::Migration
  def change
    add_column :players, :ranking_eligible,  :integer
  end
end
