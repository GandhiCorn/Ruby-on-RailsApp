class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.string :beer_club_id
      t.string :user_id

      t.timestamps null: false
    end
  end
end
