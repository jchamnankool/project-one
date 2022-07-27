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
      @entry = Entry.find params[:id]
      @tidbits = @entry.tidbits
    end

    def edit
      @entry = Entry.find params[:id]
      @tidbits = @entry.tidbits
    end

    def update
      entry = Entry.find params[:id]
      entry.update entry_params
      redirect_to entry
    end

    def destroy
      entry = Entry.find params[:id]
      entry.destroy
      redirect_to user_path(:id => @current_user.id)
    end

    private
    def entry_params
      params.require(:entry).permit(:tidbits => [])
    end
  end
  