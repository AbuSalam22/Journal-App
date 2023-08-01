class EntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_entry, only: [:show, :edit, :update, :destroy]

  def index
    @q = current_user.entries.ransack(params[:q])
    @entries = @q.result(distinct: true).paginate(page: params[:page], per_page: 5)
    @entry_count = @q.result.count
  end

  def show
    # The 'set_entry' method already sets the @entry variable for the current user
  end

  def new
    @entry = current_user.entries.new
  end

  def create
    @entry = current_user.entries.new(entry_params)
    if @entry.save
      redirect_to root_url, status: :see_other, turbo: true
    else
      render :new
    end
  end

  def edit
    # The 'set_entry' method already sets the @entry variable for the current user
  end

  def update
    if @entry.update(entry_params)
      # Check if the 'remove_image' checkbox is selected
      if params[:entry][:remove_image] == "1"
        # Remove the image attachment
        @entry.image.purge
      end
      redirect_to root_url, status: :see_other, turbo: true
    else
      render :edit
    end
  end

  def destroy
    @entry.destroy
    redirect_to root_url
  end

  private

  def entry_params
    params.require(:entry).permit(:place_name, :link, :description, :latitude, :longitude, :date_visited, :image, :remove_image).merge(user_id: current_user.id)
  end

  def set_entry
    @entry = current_user.entries.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_url, alert: "You don't have permission to perform this action."
  end
end
