class AddNewColumnsToSeasonStats < ActiveRecord::Migration
  def change
    remove_index :season_stats, name: 'index_season_stats_on_player_id_and_year'

    add_column :season_stats, :team, :string
    add_column :season_stats, :franchise_id, :string
    add_column :season_stats, :stint, :integer
    add_column :season_stats, :lg, :string
    add_column :season_stats, :war_pos, :float
    add_column :season_stats, :waa_pos, :float
    add_column :season_stats, :war_p, :float
    add_column :season_stats, :waa_p, :float
    add_column :season_stats, :hall_rating, :float
  end
end
