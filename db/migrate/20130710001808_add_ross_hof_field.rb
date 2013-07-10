class AddRossHofField < ActiveRecord::Migration
  def change
    add_column :players, :ross_hof, :boolean
  end
end
