class User < ActiveRecord::Base
  include RatingAverage

  validates :username, uniqueness: true,
                       length: { minimum: 3, maximum: 15 }

  validates :password, length: { minimum: 4 },
                       format: {
                          with: /\d.*[A-Z]|[A-Z].*\d/,
                          message: "has to contain one number and one upper case letter"
                       }

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships
  has_many :beer_clubs, through: :memberships

  has_secure_password
  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?
    fav_style_name(group_user_ratings_by_style)
  end

  def favorite_brewery
    return nil if ratings.empty?
    Brewery.find(fav_style_name(group_user_breweries_by_ratings))
  end

  def fav_style_name(hash)
    value = 0;
    string = ""
    hash.each do |k,v|
      if hash[k] > value
        value = hash[k]
        string = k
      end
    end
    string
  end

  def fav_style_rating(hash)
    value = 0;
    hash.each do |k,v|
      if hash[k] > value
        value = hash[k]
      end
    end
    value
  end

  def group_user_breweries_by_ratings
    ratings = {}
    users_ratings = self.ratings.group_by { |i| i.beer[:brewery_id]}
    users_ratings.each do |k,v|
      sum = 0.0
      v.each do |rating|
        sum += rating.score
      end
      ratings[k] = sum / v.count
    end
    ratings
  end


  def group_user_ratings_by_style
    ratings = {}
    users_ratings = self.ratings.group_by { |i| i.beer[:style]}
    users_ratings.each do |k,v|
      sum = 0.0
      v.each do |rating|
        sum += rating.score
      end
      ratings[k] = sum / v.count
    end
    ratings
  end
end