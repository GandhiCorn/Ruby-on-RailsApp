class MembershipsController < ApplicationController
  
  def new
    @membership = Membership.new
    @clubs = BeerClub.all
  end
  
  def create
    @membership = Membership.new params.require(:membership).permit(:beer_club_id)
    
    if current_user.memberships.all? { |m| m.beer_club.id != @membership.beer_club_id } and @membership.save
      current_user.memberships << @membership
      flash[:notice] = "#{current_user.username}, welcome to the club!"
      redirect_to controller: 'beer_clubs', action: 'show', id: @membership.beer_club_id
    else
      @clubs = BeerClub.all
      render :new
    end
  end
  
  def destroy
    @membership = Membership.find(params[:id])
    @membership.destroy
    flash[:notice] = "Membership in #{@membership.beer_club.name} ended." 
    redirect_to user_path current_user
  end
end