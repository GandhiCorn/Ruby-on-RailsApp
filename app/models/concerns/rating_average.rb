module RatingAverage
	extend ActiveSupport::Concern
	def average_rating
  	keskiarvo = 0.0
  	self.ratings.map {|arvio| keskiarvo += arvio.score}  	
  	keskiarvo / self.ratings.size
  end
end