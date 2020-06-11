class Kit < ApplicationRecord
  belongs_to :kit_category
  belongs_to :restaurant
end
