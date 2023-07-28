# app/models/entry.rb

class Entry < ApplicationRecord
    validates :place_name, presence: true
    validates :description, presence: true
    validates :latitude, presence: true, numericality: true
    validates :longitude, presence: true, numericality: true
    validates :date_visited, presence: true
    validates :link, format: { with: /\Ahttps?:\/\/.+/, message: "Please enter a valid URL starting with http:// or https://" }
  end
  