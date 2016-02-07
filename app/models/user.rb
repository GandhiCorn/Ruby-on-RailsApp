class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true,
                       length: { in: 3..15 }
  validates :password, format: { with: /^(?=.*[A-Z]).(?=.*[0-9]).{2,}.+$/, allow_blank: true, :multiline => true }

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships
end