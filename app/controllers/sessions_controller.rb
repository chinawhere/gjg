#coding: utf-8
class SessionsController < ApplicationController
  def login
    session[:user_return_to] ||= request.referrer || "/"
    
    service = request.protocol + request.host_with_port + "/yun_callback"
    callback_url = URI.encode(service)
    redirect_to Setting['frontend_cas_login_url'] + "?service_key=#{Setting['sso_key']}&callback_url=#{callback_url}"
  end

  def yun_callback
    if params[:ticket].present?
      res = request_sso_validate params[:ticket]
      if res.status == 200
        detail = JSON.parse Nokogiri::XML(res.body).xpath('//cas:detail').text
        @player = Player.find_by_global_id(detail['globalId'])
        @player ||= Player.construct_from_sso detail
        session[:global_id] = @player.global_id
      end
    end
    redirect_to session[:user_return_to]
  end

  def logout
    reset_session
    service = "http://" + request.host_with_port
    redirect_to Setting['frontend_cas_logout_url'] + "?service_key=" + Setting['sso_key'] + "&return_to=" + service
  end

  private
  def request_sso_validate ticket
    conn = Faraday.new url:Setting['frontend_cas_base_url']
    conn.get do |req|
      req.url '/cas/serviceValidate'
      req.params['service_key']    = Setting[:sso_key]
      req.params['ticket']         = params[:ticket]
      req.headers['Authorization'] = Setting[:sso_base64]
    end
  end
end
