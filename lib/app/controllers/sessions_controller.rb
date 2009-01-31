class SessionsController < ApplicationController

  def new
  end
  
  def create
    if user = User.authenticate(params[:email], params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Logged in successfully"
      redirect_to stored_or_default_page(person)
      return
    end
    flash[:error] = 'Login Failed'
    render :action => 'new'
  end
  
  def destroy
    reset_session
    redirect_to :action => 'new'
  end
end
