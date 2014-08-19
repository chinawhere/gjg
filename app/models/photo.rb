class Photo < ActiveRecord::Base
  attr_accessible :avatar, :event_id
  mount_uploader :avatar, PhotoAvatarUploader
  # include Rails.application.routes.url_helpers
  
  belongs_to :event
  after_save :set_event_photo_path
  before_destroy :add_event_photos
  private

  def set_event_photo_path
    photo_array = []
    event = self.event
    photo_path = event.photos_path
    photo_array = photo_path.split(',') rescue []
    if photo_array.size < 12
      photo_array << self.id
      event.update_attributes(photos_path: photo_array.join(','))
    end
  end

  def add_event_photos
    event = self.event
    photo_array = event.photos_path.split(',') rescue []
    photo_array -= [self.id.to_s]
    event.update_attributes(photos_path: photo_array.join(','))
  end
  
end
