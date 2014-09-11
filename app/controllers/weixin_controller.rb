class WeixinController < ApplicationController
  def index
  	render :text => params[:echostr]
  end

  def code
  end
end
