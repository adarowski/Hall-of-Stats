class CreateArticlesPlayers < ActiveRecord::Migration
  def up
    create_table :articles_players, :id => false do |t|
      t.integer :article_id
      t.string :player_id
    end
    add_index :articles_players, [:article_id, :player_id]
  end

  def down
    drop_table :articles_players
  end
end
