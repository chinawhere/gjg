# coding: utf-8
class Event < ActiveRecord::Base
  mount_uploader :logo, EventLogoUploader
  has_many :photos

  belongs_to :user
  has_many :comments, as: :commentable

  EVENT_CATEGORY = Hash[Category.where(status: 'event').map{|c| [c.id,c.name]}]

  FEE_TYPE = {0 => '免费', 1 => '自费', 2 => '付费', 3 => 'AA'}
  APPROVED = {0 => '正常', 2 => '取消', 6 => '结束'}

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

    def search params
      if params[:search_name].present?
        Event.where("name like ?", "%#{params[:search_name]}%").order('created_at desc')
      else
        Event.order('created_at desc')
      end
    end
  end

end
