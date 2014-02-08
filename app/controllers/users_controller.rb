class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def destroy
  end

  def signin
  end

  def create
    @user = User.new(user_params)  
    if @user.save
      flash[:success] = "Welcome to MMRC's ticketing system!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
  	@user = User.find(params[:id])
  end

  private

    def user_params
      params.require(:user).permit(:userName,:firstName, :lastName, :email, :password,
                                   :password_confirmation)
    end
  
end
