class AddPersonalHofField < ActiveRecord::Migration
  def change
    add_column :players, :personal_hof, :boolean
  end
end
