class CreateFranchiseRatings < ActiveRecord::Migration
  def change
    create_table :franchise_ratings, id: false do |t|
      t.string  :player_id, null: false
      t.string  :franchise_id, null: false
      t.decimal :hall_rating
      
      t.timestamps 
    end
    add_index :franchise_ratings, :player_id
    add_index :franchise_ratings, :franchise_id
    add_index :franchise_ratings, [:player_id, :franchise_id], unique: true
  end
end
