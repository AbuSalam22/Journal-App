class EntriesController < ApplicationController
    def index
      @entries = Entry.all
    end
  
    def new
      @entry = Entry.new
    end
  
    def create
      @entry = Entry.new(entry_params)
      if @entry.save
        redirect_to root_url, status: :see_other, turbo: true
      else
        render :new
      end
    end
  
    def edit
      @entry = Entry.find(params[:id])
    end
  
    def update
      @entry = Entry.find(params[:id])
      if @entry.update(entry_params)
        redirect_to root_url, status: :see_other, turbo: true
      else
        render :edit
      end
    end
  
    def destroy
      Entry.find(params[:id]).destroy
      redirect_to root_url
    end
  
    private
  
    def entry_params
      params.require(:entry).permit(:place_name, :link, :description, :latitude, :longitude, :date_visited)
    end
  end
  