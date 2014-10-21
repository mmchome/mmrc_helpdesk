class UsersController < ApplicationController

  before_action :signed_in_user, only: [:edit, :update, :show]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:destroy, :update]

  def new
  	@user = User.new
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  def signin
  end

  def update
    @user = User.find(params[:id])
    if  user_params[:password].blank?
      user_params.delete(:password)
      user_params.delete(:password_confirmation)
    end
  
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)  
    if @user.save
      flash[:success] = "Welcome to MMRC's ticketing system!"
      redirect_to @user
      UserMailer.welcome_email(@user).deliver
    else
      render 'new'
    end
  end

  def show
  	@user = User.find(params[:id])
    @reported_by_ticket = @user.reported_by_tickets.paginate(page: params[:page])
    @assigned_to_ticket = @user.assigned_to_tickets.paginate(page: params[:page])
  end

  def index
    @users = User.paginate(page: params[:page])
  end


  private

    def user_params
      params.require(:user).permit(:username,:first_name, :last_name, :email,:user_types_id,:password,:password_confirmation,)   #not complete usertypes will need to be added separately
    end
    
    def admin_user
      redirect_to(root_url) unless current_user.user_types_id==1
    end


    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)||current_user.user_types_id==1
    end
  
end
