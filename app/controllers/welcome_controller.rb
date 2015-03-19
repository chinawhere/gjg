#coding: utf-8
class WelcomeController < ApplicationController

  def index
    render text: request.ip and return
  	@events = Event.limit(10)
  end

end
