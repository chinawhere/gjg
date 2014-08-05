# coding: utf-8
class Event < ActiveRecord::Base
  attr_accessible :category_id, :name, :address, :start_at, :end_at, :fee_type, :fee, :max_count, :min_count, :content, :logo
  mount_uploader :logo, EventLogoUploader

  belongs_to :user

  EVENT_CATEGORY = Hash[Category.where(status: 'event').map{|c| [c.id,c.name]}]

  # FEE_TYPE = {0 => '免费', 1 => '付费', 2 => 'AA'}
end
