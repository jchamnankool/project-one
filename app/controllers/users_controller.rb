class UsersController < ApplicationController
    before_action :check_for_login
    before_action :check_for_admin, :only => [:index]
  
    def index
      @users = User.all
    end
  
    def new
      @user = User.new
    end
  
    def create
      user_params[:name].capitalize!
      # create user in memory first
      @user = User.new user_params
      # if successful redirect to right page
      if @user.save
        session[:user_id] = @user.id
        redirect_to dashboard_path
      else
        # render same page again
        render :new
      end
    end

    def show # "profile"
      @user = User.find_by_id params[:id]
      @entries = @user.entries
    end

    def follow
      @current_user.following << params[:id]
      followed_user = User.find_by_id params[:id]
      followed_user.followers << @current_user.id
      followed_user.save
      @current_user.save
      redirect_back(fallback_location: root_path)
    end

    def unfollow
      @current_user.following.delete params[:id]
      unfollowed_user = User.find_by_id params[:id]
      unfollowed_user.followers.delete @current_user.id.to_s
      unfollowed_user.save
      @current_user.save
      redirect_back(fallback_location: root_path)
    end
  
    private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  end
  