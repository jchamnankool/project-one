class UsersController < ApplicationController
    before_action :check_for_login, :except => [:new, :create]
    before_action :check_for_admin, :only => [:index]
  
    def index
      @users = User.all
    end
  
    def new
      if @current_user.present?
        redirect_to dashboard_path
      else
        @user = User.new
      end
    end
  
    def create
      user_params[:name].capitalize!
      @user = User.new user_params

      if params[:file].present?
        req = Cloudinary::Uploader.upload(params[:file])
        @user.avatar = req["public_id"]
      end

      if @user.save
        session[:user_id] = @user.id
        redirect_to dashboard_path
      else
        # render same page again
        render :new
      end
    end

    def edit
      @user = User.find_by_id params[:id]
    end

    def update
      user_params[:name].capitalize!
      user = User.find_by_id params[:id]

      if params[:file].present?
        req = Cloudinary::Uploader.upload(params[:file])
        user.avatar = req["public_id"]
      end

      if user.save
        user.update user_params
        redirect_to dashboard_path
      else
        render :edit
      end
    end

    def show # "profile"
      @user = User.find_by_id params[:id]
      @entries = @user.entries
    end

    def follow
      @user = User.find(params[:id])
      @current_user.followees << @user
      redirect_back(fallback_location: user_path(@user))
    end
    
    def unfollow
      @user = User.find(params[:id])
      @current_user.followed_users.find_by(followee_id: @user.id).destroy
      redirect_back(fallback_location: user_path(@user))
    end
  
    private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
    end
  end
  