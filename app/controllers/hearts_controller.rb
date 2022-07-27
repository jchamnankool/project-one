class HeartsController < ApplicationController
    before_action :check_for_login
  
    def new
      @heart = Heart.new
    end
  
    def create
      liked_entry = Entry.find_by_id heart_params[:entry_id]
      current_user_heart = liked_entry.hearts.find{ |h| h.user_id == @current_user.id }

      if current_user_heart # if current user has already liked the entry
        liked_entry.hearts.delete(current_user_heart)
        heart = Heart.find current_user_heart.id
        heart.destroy
      else
        heart = Heart.new heart_params
        liked_entry.hearts << heart
      end

      liked_entry.save
      redirect_to user_path(:id => liked_entry[:user_id])
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
  