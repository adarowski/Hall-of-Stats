class AddPhotoPathToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :photo_path, :string

    execute "update players set photo_path = 'thumbs/munsoth01.jpg' where id = 'munsoth01'"
  end
end
