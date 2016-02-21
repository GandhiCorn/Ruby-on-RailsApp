class PlacesController < ApplicationController
  def index
  end
  
  def show
    @place = Rails.cache.read("last_search").find { |place| place.id == params[:id] }
  end
  
  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      Rails.cache.write "last_search", @places
      render :index
    end
  end
end