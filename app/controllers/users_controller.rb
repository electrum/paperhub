class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    p = params[:user].slice(:username, :email, :password, :password_confirmation)
    @user = User.new(p)
    if @user.save
      reset_session
      session[:user_id] = @user.id
      redirect_to root_url, :notice => 'Account created!'
    else
      render :new
    end
  end
end