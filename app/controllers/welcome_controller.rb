#coding: utf-8
class WelcomeController < ApplicationController
  def index
  	render :text => '1111' and return
  	@events = Event.limit(10)
  end

  def test
  	render :layout => false
  end
end