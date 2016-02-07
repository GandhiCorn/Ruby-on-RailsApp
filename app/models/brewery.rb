class Brewery < ActiveRecord::Base
	include RatingAverage

	validates_presence_of :name
	validates :year, numericality: { greater_than_or_equal_to: 1042,
                                    less_than_or_equal_to: 2016,
                                    only_integer: true }
	
	has_many :beers, dependent: :destroy
	has_many :ratings, through: :beers

end
