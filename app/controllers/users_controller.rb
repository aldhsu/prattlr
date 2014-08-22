class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      if User.find_by(username: params[:user][:username])
        redirect_to new_user_path, flash: {notice: "Username already taken."}
      else
        redirect_to new_user_path, flash: {notice: "Passwords error."}
      end
    end
  end

  def new
    @user = User.new
  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end

