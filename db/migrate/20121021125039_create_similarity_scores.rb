class CreateSimilarityScores < ActiveRecord::Migration
  def change
    create_table :similarity_scores, id: false do |t|
      t.string  :player1_id, null: false
      t.string  :player2_id, null: false
      t.decimal :score,      null: false, scale: 1
      t.timestamps
    end

    add_index :similarity_scores, :player1_id
    add_index :similarity_scores, :player2_id
    add_index :similarity_scores, [:player1_id, :player2_id], unique: true
  end
end
