class AddBioAndRenderedBioToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :editable_bio, :text
    add_column :players, :rendered_bio, :text
  end
end
