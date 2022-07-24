class EntriesController < ApplicationController
    before_action :check_for_login
  
    def new
      @entry = Entry.new
    end
  
    def create
      entry = Entry.create entry_params
      @current_user.entries << entry # establishes ownership
      redirect_to entry
    end
    
    def show
      entry = Entry.where(user_id: @current_user.id).last
      @tidbits = entry.tidbits
    end

    private
    def entry_params
      params.require(:entry).permit(:tidbits => [])
    end
  end
  