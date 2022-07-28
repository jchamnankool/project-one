class HeartsController < ApplicationController
    before_action :check_for_login
  
    def new
      @heart = Heart.new
    end
  
    def create
      liked_entry = Entry.find_by_id heart_params[:entry_id]
      current_user_heart = liked_entry.hearts.find{ |h| h.user_id == @current_user.id }

      if current_user_heart # if current user has already liked the entry
        Entry.find_by_id(heart_params[:entry_id]).hearts.delete(current_user_heart)
        User.find_by_id(heart_params[:user_id]).hearts.delete(current_user_heart)
        heart = Heart.find current_user_heart.id
        heart.destroy
      else
        heart = Heart.new heart_params
        Entry.find_by_id(heart_params[:entry_id]).hearts << heart
        User.find_by_id(liked_entry[:user_id]).entries.find_by_id(heart_params[:entry_id]).hearts << heart
      end

      Entry.find_by_id(heart_params[:entry_id]).save
      User.find_by_id(heart_params[:user_id]).save
      redirect_back(fallback_location: root_path)
    end

    def destroy
        heart = Heart.find params[:id]
        heart.destroy
    end
  
    private
    def heart_params
      params.require(:heart).permit(:user_name, :user_id, :entry_id)
    end
  end
  