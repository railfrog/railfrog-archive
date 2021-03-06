module Railfrog
  # Check a User is Logged In
  def logged_in?
    session[:user_id]
  end

  # Ensure a User is Logged In
  def ensure_logged_in
    return true if logged_in?
    flash[:error] = 'Please Log In'
    #redirect_to_login
    redirect_to :controller => 'users', :action => 'login'
    return false
  end
end
