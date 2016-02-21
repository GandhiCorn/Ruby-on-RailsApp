class ChangeBeerStyle < ActiveRecord::Migration
  def change
    remove_column :beers, :style, :string
    add_column :beers, :style, :integer
  end
end