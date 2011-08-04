class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    p = params[:user].slice(:username, :email, :password, :password_confirmation)
    p[:username] = p[:username].downcase
    @user = User.new(p)
    if @user.save
      reset_session
      session[:user_id] = @user.id
      redirect_to root_url, :notice => 'Account created!'
    else
      render :new
    end
  end

  def show
    @user = User.find_by_username!(params[:id])
    @bookmarks = @user.bookmarks
  end
end
