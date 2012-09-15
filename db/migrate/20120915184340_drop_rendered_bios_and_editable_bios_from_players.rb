class DropRenderedBiosAndEditableBiosFromPlayers < ActiveRecord::Migration
  def up
    remove_column :players, :editable_bio
    remove_column :players, :rendered_bio
  end

  def down
    add_column :players, :editable_bio, :text
    add_column :players, :rendered_bio, :text
  end
end
