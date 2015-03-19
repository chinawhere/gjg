#coding: utf-8
class WelcomeController < ApplicationController

  def index
    res = Faraday.get %{http://ip.taobao.com/service/getIpInfo.php?ip=#{request.ip}}
    parsed_json = JSON.parse res.body
    render text: parsed_json['city_id'] and return
  	@events = Event.limit(10)
  end

end
