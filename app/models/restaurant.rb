require 'uri'

class Restaurant < ApplicationRecord
  has_one :restaurant_category

  has_many :kits, dependent: :destroy

  validates :name, presence: true, length: { minimum: 6 }
  validates :description, presence: true, length: { minimum: 20 }

  # ? should we split out locations (is that useful information?)
  validates :city, presence: true, length: { minimum: 3 }
  # uses the UK gov post code RegExp to validate
  validates :postcode, presence: true, format: { with: /([Gg][Ii][Rr] 0[Aa]{2})|((([A-Za-z][0-9]{1,2})|(([A-Za-z][A-Ha-hJ-Yj-y][0-9]{1,2})|(([A-Za-z][0-9][A-Za-z])|([A-Za-z][A-Ha-hJ-Yj-y][0-9][A-Za-z]?))))\s?[0-9][A-Za-z]{2})/, message: 'Not a valid UK post code'}
  validates :address1, presence: true, length: { minimum: 10 }

  # URI.regexp provides built-in regexp for different URL types (in this case, http and https)
  validates :website_url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }
  validates :email, presence: true, format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, message: 'Not a valid email address' }

  # TODO: add geocoding (long, lat columns) with a geocoder gem/API (Mapbox? Google?)
  # TODO: add logo and photos for restaurants (Cloudinary or something else?)
end
