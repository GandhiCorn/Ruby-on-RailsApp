class ChangeBeerStyleAgain < ActiveRecord::Migration
  def change
    remove_column :beers, :style, :integer
    add_column :beers, :style_id, :integer
  end
end