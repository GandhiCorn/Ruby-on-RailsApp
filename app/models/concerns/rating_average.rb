module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    return 0 if Rating.all.empty?
    ratings.inject(0.0) { |sum, r| sum+r.score } / ratings.count
  end
end