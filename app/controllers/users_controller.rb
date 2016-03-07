class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.includes(:beers, :ratings).all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @beer_clubs = BeerClub.all
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.provider.nil?
        if user_params[:username].nil? && @user == current_user && @user.update(user_params)
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to @user, notice: 'Go to your provider to change password.' }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if (@user == current_user or current_user.admin?)
      session[:user_id] = nil unless @user != current_user
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      format.html { render :edit, notice: "Can't destroy other users." }
      format.json { render json: @user.errors, status: :unprocessable_entity }
    end
  end


  def toggle_suspension
    user = User.find(params[:id])
    if (current_user.admin and not user.admin)
      user.update_attribute :suspended, (not user.suspended)

      new_status = user.suspended? ? "frozen" : "reactivated"

      redirect_to :back, notice: "Account was successfully #{new_status}"
    else
      redirect_to :back, notice: "Cannot freeze account"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation)
    end
end