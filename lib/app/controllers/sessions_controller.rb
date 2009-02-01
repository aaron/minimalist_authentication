class SessionsController < ApplicationController
  append_view_path File.join(File.dirname(__FILE__), '..', 'views')

  def new
  end
  
  def create
    if user = User.authenticate(params[:email], params[:password])
      user.logged_in
      session[:user_id] = user.id
      flash[:notice] = "Logged in successfully"
      redirect_back_or_default('/')
      return
    else
      flash[:error] = 'Login Failed'
      render :action => 'new'
    end
  end
  
  def destroy
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_to '/'
  end
end
