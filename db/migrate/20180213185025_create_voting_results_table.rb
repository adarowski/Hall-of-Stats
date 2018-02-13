class CreateVotingResultsTable < ActiveRecord::Migration
  def change
    create_table :voting_results do |t|
      t.string :player_id, null: false
      t.integer :year, null: false
      t.string :type, null: false, default: "bbwaa"
      t.integer :ballots, null: false
      t.integer :votes, null: false
      t.float :pct, null: false
      t.boolean :inducted, default: false
      t.boolean :dropped, default: false

      t.timestamps
    end

    add_index :voting_results, :player_id
  end
end
