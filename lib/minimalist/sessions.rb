module Minimalist
  module Sessions
    def self.included( base )
      base.extend(ClassMethods)
      base.class_eval do
        include InstanceMethods
        append_view_path File.join(File.dirname(__FILE__), '..', '/app/views')
      end
    end
    
    module InstanceMethods
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
  end
end