# app/models/entry.rb

class Entry < ApplicationRecord
  belongs_to :user # Defines a one-to-one association with the 'User' model
  has_one_attached :image # Allows attaching an image to the entry using Active Storage

  validates :place_name, presence: true # Ensures that 'place_name' is present (not blank)
  validates :description, presence: true # Ensures that 'description' is present (not blank)
  validates :latitude, presence: true, numericality: true # Ensures 'latitude' is present and a numeric value
  validates :longitude, presence: true, numericality: true # Ensures 'longitude' is present and a numeric value
  validates :date_visited, presence: true # Ensures that 'date_visited' is present (not blank)
  validates :link, format: { with: /\Ahttps?:\/\/.+/, message: "Please enter a valid URL starting with http:// or https://" }
  # Ensures 'link' follows the specified format for a URL starting with 'http://' or 'https://'

  def self.ransackable_attributes(auth_object = nil)
    %w[place_name description latitude longitude date_visited link]
    # Defines the attributes that can be used for searching using the Ransack gem
  end

  attr_accessor :remove_image
  # Creates a virtual attribute 'remove_image', not backed by the database

  def remove_image=(value)
    image.purge if value == "1"
    # If 'remove_image' is set to "1" (checked), removes the attached image from Active Storage
  end
end
