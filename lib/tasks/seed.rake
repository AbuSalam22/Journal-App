# lib/tasks/seed.rake
namespace :db do
    desc 'Seed the database with more accurate dummy entries'
    task seed: :environment do
      entry_count = 20 # Set the number of entries to 20
  
      entry_count.times do
        city = Faker::Address.city
        country = Faker::Address.country
        location = "#{city}, #{country}"
  
        coordinates = nil
  
        # Retry geocoding with different locations until valid coordinates are obtained
        while coordinates.nil?
          coordinates = Geocoder.coordinates(location)
          city = Faker::Address.city
          country = Faker::Address.country if coordinates.nil?
          location = "#{city}, #{country}"
        end
  
        Entry.create!(
          place_name: location,
          description: Faker::Lorem.paragraph,
          latitude: coordinates[0],
          longitude: coordinates[1],
          date_visited: Faker::Date.between(from: 10.year.ago, to: Date.today),
          link: Faker::Internet.url,
          # Add other attributes as needed
        )
      end
    end
  end
  