class SlideAd < ActiveRecord::Base
	validates_presence_of :title, :link, :img
	mount_uploader :img, SlideAdImgUploader
end
