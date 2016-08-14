class CreateFranchisePlayerDurations < ActiveRecord::Migration
  def change
    create_table :franchise_player_durations do |t|
      t.string :player_id
      t.string :franchise_id
      t.integer :start_year
      t.integer :end_year

      t.timestamps
    end

    add_index :franchise_player_durations, [:player_id, :franchise_id]
  end
end
