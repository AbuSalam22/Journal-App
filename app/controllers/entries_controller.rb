class EntriesController < ApplicationController
  before_action :authenticate_user! # Ensures that the user is logged in before accessing any actions
  before_action :set_entry, only: [:show, :edit, :update, :destroy] # Calls 'set_entry' method before 'show', 'edit', 'update', and 'destroy' actions

  def index
    @q = current_user.entries.ransack(params[:q]) # Search entries belonging to the current user
    @entries = @q.result(distinct: true).paginate(page: params[:page], per_page: 5) # Paginates the search results and stores them in '@entries'
    @entry_count = @q.result.count # Count of total entries for the current user based on the search
  end

  def show
    # The 'set_entry' method already sets the @entry variable for the current user
    puts "Latitude: #{@entry.latitude}" # Displays the latitude of the entry
    puts "Longitude: #{@entry.longitude}" # Displays the longitude of the entry
  end

  def new
    @entry = current_user.entries.new # Creates a new entry for the current user
  end

  def create
    @entry = current_user.entries.new(entry_params) # Creates a new entry with the provided parameters
    if @entry.save
      redirect_to root_url, status: :see_other, turbo: true # Redirects to the root page after successful entry creation
    else
      render :new # Re-renders the new entry form if there are errors
    end
  end

  def edit
    # The 'set_entry' method already sets the @entry variable for the current user
  end

  def update
    if @entry.update(entry_params) # Updates the entry with the provided parameters
      # Check if the 'remove_image' checkbox is selected
      if params[:entry][:remove_image] == "1" # If the 'remove_image' checkbox is checked
        # Remove the image attachment
        @entry.image.purge
      end
      redirect_to root_url, status: :see_other, turbo: true # Redirects to the root page after successful update
    else
      render :edit # Re-renders the edit entry form if there are errors
    end
  end

  def destroy
    @entry.destroy # Deletes the entry from the database
    redirect_to root_url # Redirects to the root page after successful deletion
  end

  private

  def entry_params
    # Permits the specific entry attributes and merges the 'user_id' with the current user's ID
    params.require(:entry).permit(:place_name, :link, :description, :latitude, :longitude, :date_visited, :image, :remove_image).merge(user_id: current_user.id)
  end

  def set_entry
    @entry = current_user.entries.find(params[:id]) # Finds the entry belonging to the current user with the provided ID
  rescue ActiveRecord::RecordNotFound
    redirect_to root_url, alert: "You don't have permission to perform this action." # Redirects to the root page with an error message if the entry is not found
  end
end
