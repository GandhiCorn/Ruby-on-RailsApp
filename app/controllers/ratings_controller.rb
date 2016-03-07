class RatingsController < ApplicationController
  def index

    @recent = Rating.recent

    Rails.cache.write("beer top 3", Beer.top(3), expires_in: 10.minutes) if Rails.cache.read("beer top 3").nil?
    @beers = Rails.cache.read("beer top 3")

    Rails.cache.write("style top 3", Style.top(3), expires_in: 10.minutes) if Rails.cache.read("style top 3").nil?
    @styles = Rails.cache.read("style top 3")

    Rails.cache.write("brewery top 3", Brewery.top(3), expires_in: 10.minutes) if Rails.cache.read("brewery top 3").nil?
    @breweries = Rails.cache.read("brewery top 3")

    Rails.cache.write("user top 3", User.top(4), expires_in: 10.minutes) if Rails.cache.read("user top 3").nil?
    @users = Rails.cache.read("user top 3")
  end

  def new
    expire_fragment('ratingcolumns')
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    expire_fragment('ratingcolumns')
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
    expire_fragment('ratingcolumns')
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to :back
  end
end