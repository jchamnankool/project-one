class UsersController < ApplicationController
    before_action :check_for_admin, :only => [:index]
  
    def index
      @users = User.all
    end
  
    def new
      @user = User.new
    end
  
    def create
      # create user in memory first
      @user = User.new user_params
      # if successful redirect to right page
      if @user.save
        session[:user_id] = @user.id
        redirect_to root_path
      else
        # render same page again
        render :new
      end
    end
  
    private
    def user_params
      params.require(:user).permit(:email, :dob, :password, :password_confirmation)
    end
  end
  