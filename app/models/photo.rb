class Photo < ActiveRecord::Base
  attr_accessible :avatar, :event_id
  mount_uploader :avatar, PhotoAvatarUploader
  # include Rails.application.routes.url_helpers
  
  belongs_to :event
  
end
