class CreateSeasonStats < ActiveRecord::Migration
  def change
    create_table :season_stats, id: false do |t|
      t.string :player_id, null: false
      t.integer :year, null: false
      t.float :waa_tot, null: false
      t.float :war_tot, null: false

      t.timestamps
    end
    add_index :season_stats, :player_id
    add_index :season_stats, [:player_id, :year], unique: true
  end
end
