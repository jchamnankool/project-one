class PagesController < ApplicationController
    def home
    end

    def dashboard
      @user = User.find_by_id(session[:user_id])
    end
end
  