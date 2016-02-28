class RatingsController < ApplicationController
  
  def index
    @ratings = Rating.all
    @latest_ratings = Rating.recent
    @best_breweries = Brewery.top 3
    @best_beers = Beer.top 3
    @best_styles = Style.top 3
    @most_active_raters = User.top 3
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)

    if @rating.save
      current_user.ratings << @rating
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to :back
  end
end