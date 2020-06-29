class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def service_urls
    urls = []
    self.photos.each do |photo|
      urls << photo.service_url
    end
    urls
  end

  def tag_names
    tags = []
    self.tags.each do |tag|
      tags << tag.name
    end
    tags
  end
end
