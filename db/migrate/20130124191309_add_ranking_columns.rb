class AddRankingColumns < ActiveRecord::Migration
  def change
    add_column :players, :ranking_overall,  :integer
    add_column :players, :ranking_position, :integer
    add_column :players, :ranking_hof,      :integer
    add_column :players, :ranking_hos,      :integer
  end
end
