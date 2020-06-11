class KitCategory < ApplicationRecord
  belongs_to :kit

  validates :name, presence: true, length: { minimum: 6 }

  # TODO: Add categories via seed
end
