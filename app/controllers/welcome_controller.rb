#coding: utf-8
class WelcomeController < ApplicationController

  def index
  	# @events = Event.where(city_code: current_city.code).limit(8)
  	@events = Event.where("city_code= ? and start_at > ?", current_city.code, Time.now).limit(8)
  	# @events = Event.where("start_at > ?", Time.now).limit(8)
  end
  def show_events
  	now_time = Time.now
  	case params[:state]
  	when 'new' then
  	  @events = Event.where("city_code= ? and start_at > ?", current_city.code, now_time).limit(8)
  	when 'progress' then
  		@events = Event.where("city_code= ? and start_at < ? and end_at > ?", current_city.code, now_time, now_time).limit(8)
  	when 'end' then
  		@events = Event.where("city_code= ? and end_at < ?",current_city.code, now_time).limit(8)
  	else
  		@events = Event.where("city_code= ?",current_city).limit(8)
  	end
  end
end
