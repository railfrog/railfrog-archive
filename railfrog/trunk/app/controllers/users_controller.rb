require 'digest/sha1'

class UsersController < ApplicationController  
  include UsersHelper
  layout 'railfrog_admin'
  
  before_filter :ensure_logged_in, :only => [ :index, :list ]

  if User.count > 0
    before_filter :ensure_logged_in, :only => [ :new, :create ]
  end
  
  # Login Authentication
  def authenticate
    encrypted_password = Digest::SHA1.hexdigest params[:password]
    user = User.find_by_email_and_password params[:email], encrypted_password
    if user
      session[:user_id] = user.id
      # ToDo: Store user details in a hash in the session state
      session[:first_name] = user.first_name
      session[:last_name] = user.last_name
      redirect_to rf_admin_url
    else
      flash[:error] = :login_failed.l('Log In Failed')
      redirect_to :action => 'login'
      return
    end
  end
  
  # Logout
  # ToDo: Return URI
  def logout
    session[:user_id] = nil
    session[:first_name] = nil
    session[:last_name] = nil
    flash[:notice] = :logout_successful.l('Logout Successful')
    redirect_to ''
  end
  
  # User Administration
  def index
    list
    render :action => 'list'
  end

  def list
    @user_pages, @users = paginate :users, :per_page => 10
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = :user_successfully_created.l('User Successfully Created')
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end
end
