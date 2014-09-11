class WeixinController < ApplicationController
  def index
  	render :text => params[:echostr]
  end

  def code
  	if params[:code].present?
  		res = Faraday.post "https://api.weixin.qq.com/sns/oauth2/access_token", {
  			:appid => "wx7cdd37389daaf639",
  			:secret => "b8caf1ccbf6e520c6801c071052ba813",
  			:code => params[:code],
  			:grant_type => "authorization_code"
  		}
  		parsed_json = JSON.parse res.body
  		render :text => parsed_json['access_token']
  	else
  		redirect_to "http://www.baidu.com"
  	end
  end
end