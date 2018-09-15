class SessionsController < ApplicationController
  
  def new
    render :new
  end
  
  def create
    user = User.find_by_credentials(params[:user][:username],params[:user][:password])
    if user
      login!(user)
      redirect_to user_url(user)
    else
      flash.now[:errors] = ["Wrong Credentials"]
      render :new
    end
  end
  
  def destroy
    logout! if logged_in?
    redirect_to new_session_url
  end
  
end