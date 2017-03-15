class UsersController < ApplicationController
  def new
  	#debugger
  	@user = User.new
  end
  def show
  	@user = User.find(params[:id])
  	#debugger
  end
  def create
  	@user = User.new(user_params)
  	if @user.save
      log_in @user
  		flash[:success] = "Welcome to the sample app"
  		redirect_to user_url(@user)
  	else
  	  render 'new'
  	end
  end

  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
