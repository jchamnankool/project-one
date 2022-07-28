class PagesController < ApplicationController
    def home
    end

    def dashboard
      @user = User.find_by_id(session[:user_id])
      @tidbitsCount = @user.entries.count * 3
      @followerCount = @user.followers.count
      @following = @user.following
      @followingCount = @following.count
      @heartsCount = 0;
      @user.entries.each {|e| @heartsCount += e.hearts.count}

      @feed = []
      @following.each do |follow_id|
        User.find_by_id(follow_id).entries.each do |entry|
          @feed << entry
        end
      end
      @feed = @feed.sort_by { |e| e["created_at"] }.reverse
    end
end
  