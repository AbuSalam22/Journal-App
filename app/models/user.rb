class User < ApplicationRecord
  has_many :entries # Defines a one-to-many association with the 'Entry' model
  # This means a user can have multiple entries associated with them.

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Configures Devise authentication modules for the 'User' model
end
