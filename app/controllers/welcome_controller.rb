#coding: utf-8
class WelcomeController < ApplicationController

  def index
    res = Faraday.get %{http://ip.taobao.com/service/getIpInfo.php?ip=#{request.ip}}
    if res.status == 200
      parsed_json = JSON.parse res.body
      if parsed_json['code'] == 0
        render text: parsed_json['data']['city_id'] and return
      end
    end
    render text: 'error' and return
  	@events = Event.limit(10)
  end

end
