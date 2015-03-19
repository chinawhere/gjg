#coding: utf-8
class WelcomeController < ApplicationController

  def index
    res = Faraday.get %{http://ip.taobao.com/service/getIpInfo.php?ip=#{request.ip}}
    render text: res.inspect and return
  	@events = Event.limit(10)
  end

end
