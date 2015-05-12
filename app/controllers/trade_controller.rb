class TradeController < ApplicationController
  def index
  	render "index", :formats => :xml
  end

  def call_back
  	render :text => params
  end
end