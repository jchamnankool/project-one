class PagesController < ApplicationController
    before_action :check_for_login, only: :dashboard

    def home
      redirect_to dashboard_path if @current_user.present?
    end

    def dashboard
      @user = User.find_by_id(session[:user_id])
      @tidbits_count = @user.entries.count * 3
      @follower_count = @user.followers.count
      @following = @user.followees
      @following_count = @following.count
      @hearts_count = 0;
      @user.entries.each {|e| @hearts_count += e.hearts.count}

      @feed = []
      @following.each do |follow_id|
        User.find_by_id(follow_id).entries.each do |entry|
          @feed << entry
        end
      end
      @feed = @feed.sort_by { |e| e["created_at"] }.reverse

      users = User.all
      @random_user_id = users[rand(0...User.count)].id
      while @random_user_id == @current_user.id do
        @random_user_id = users[rand(0...User.count)].id
      end
    end
end
  