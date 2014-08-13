# coding: utf-8
class Event < ActiveRecord::Base
  attr_accessible :category_id, :name, :address, :start_at, :end_at, :fee_type, :fee, :max_count, :min_count, :content, :logo, :photos_path
  mount_uploader :logo, EventLogoUploader
  has_many :photos

  belongs_to :user

  EVENT_CATEGORY = Hash[Category.where(status: 'event').map{|c| [c.id,c.name]}]

  FEE_TYPE = {0 => '免费', 1 => '自费', 2 => '付费', 3 => 'AA'}

  def photo_ids
    self.photos_path.split(',') rescue []
  end

  def display_fee
    Event::FEE_TYPE[self.fee_type]
  end

end
