class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :BeerClub
  validates :user_id, presence: true
  validates :beer_club_id, presence: true
end