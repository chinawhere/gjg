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

  class << self

    #活动日历
    def events_calendar
      ret = []
      Event.all.each do |event|
        #最大活动间隔10天
        start_date = [event.start_at.to_date, event.end_at.to_date - 20.days].max
        start_date.upto(event.end_at.to_date) do |x|
          ret << {date: x.strftime("%Y-%m-%d"), title: event.name, url: "#{$host}/events/#{event.id}"}
        end
      end
      ret.group_by{|x| x.values.first}.map{|k, v| {date: k, title: v.flat_map{|x| x[:title]}, url: v.flat_map{|x| x[:url]}}}
    end
  end

end
