#coding: utf-8
class WelcomeController < ApplicationController

  def index
  	@events = Event.limit(10)
  end

end
