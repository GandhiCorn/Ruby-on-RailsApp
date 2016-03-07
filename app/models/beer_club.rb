class BeerClub < ActiveRecord::Base
  has_many :memberships, -> { where confirmed: true}
  has_many :members, through: :memberships, source: :user

  def index
    @beer_clubs = BeerClub.all
  end

  def to_s
    "#{self.name} #{self.city}"
  end

  def self.free(user_id)
    f = []
    BeerClub.all.each do |bc|
      if not bc.memberships.pluck(:user_id).include? user_id
        f << bc
      end
    end
    return f
  end


end