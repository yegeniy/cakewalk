class ApplicationController < ActionController::Base
#  include SslRequirement
  helper :all # include all helpers, all the time
  has_mobile_fu
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery :secret => '8fc080370e56e929a2d5afca5540a0f7'
 # before_filter :prepare_for_mobile
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
    
protected
  def requirelogin
    unless User.find_by_id(session[:user_id])
      flash[:notice] = "Please log in"
      redirect_to :controller => 'admin', :action => 'login'
    end
  end
  
  def testadmin
    unless User.find_by_id(session[:user_id]).getadmin ==1
      flash[:notice] = "You are not an admin...."
      redirect_to :controller => 'admin', :action => 'login'
    end
    rescue
      flash[:notice]= "Please log in first.."
      redirect_to :controller => 'admin', :action => 'login'
  end    
  
  def mobile_device?
  	if session[:mobile_param]
  		session[:mobile_param] == "1"
  	else
  		request.user_agent =~ /Mobile|webOS/
  	end
  end
  helper_method :mobile_device?
  
  def prepare_for_mobile
  	session[:mobile_param]= params[:mobile] if params[:mobile]
  	request.format = :mobile if mobile_device?
  end				
   
end
