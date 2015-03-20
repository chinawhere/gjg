#coding: utf-8
class WelcomeController < ApplicationController

  def index
    render text: 'hello' and return
  	@events = Event.where(city_code: current_city.code).limit(8)
  end

end
