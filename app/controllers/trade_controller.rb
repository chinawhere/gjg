class TradeController < ApplicationController
  def index
  	render "index", :formats => :xml
  end
end