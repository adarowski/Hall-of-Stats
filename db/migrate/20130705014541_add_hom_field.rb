class AddHomField < ActiveRecord::Migration
  def change
    add_column :players, :hom, :boolean
  end
end
