class AddNicknameField < ActiveRecord::Migration
  def change
    add_column :players, :nickname, :string
  end
end
