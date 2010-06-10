class AdminController < ApplicationController

  # just display the form and wait for user to
  # enter a name and password
  
  def login
    if request.post?
      user = User.authenticate(params[:name], params[:password])
      if user
        isadmin=user.isadmin?
        session[:user_id] = user.id
        if(isadmin)
          redirect_to(:action => "welcome")
        else
          flash.now[:notice] = "You are not an administrator..." 
        end   
      else
        flash.now[:notice] = "Invalid user/password combination"
      end
    end
  end
    
  def logout
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to(:action => "login")
  end
  
  
  def index
   if request.post?
    user=User.authenticate(params[:name], params[:password])
    isadmin=user.isadmin?
    if(isadmin)
      redirect_to(:action => "welcome")
    else
      flash[:notice] = "You are not an administrator..."
      redirect_to(:action => "login")
    end    
  end  
      
  end
  
end
