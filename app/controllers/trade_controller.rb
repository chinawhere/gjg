class TradeController < ApplicationController
	skip_before_filter :verify_authenticity_token
	before_filter :check_weixin_legality, only: ['call_back']
  def index
  	render :text => "index"
  end

  def call_back
  	# render :text => params
  	render :text => params[:echostr]
  end

  private
  # 根据参数校验请求是否合法，如果非法返回错误页面
  def check_weixin_legality
    array = [Rails.configuration.weixin_token, params[:timestamp], params[:nonce]].sort
    render :text => "Forbidden", :status => 403 if params[:signature] != Digest::SHA1.hexdigest(array.join)  	
  end
end