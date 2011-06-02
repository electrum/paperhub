class SessionsController < ApplicationController
  def new
    # empty
  end

  def create
    user = User.authenticate(params[:username], params[:password])
    if user
      reset_session
      session[:user_id] = user.id
      redirect_to root_url
    else
      flash.now.alert = 'Invalid username or password'
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_url
  end
end
