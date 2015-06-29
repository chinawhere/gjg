require 'open-uri'
require 'rest_client'
class TradeController < ApplicationController
	skip_before_filter :verify_authenticity_token
	before_filter :check_weixin_legality, only: ['lzj']
  def index
  	render :text => "index111"
  end

  #获取access token
  def get_access_token
    uri = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=#{Rails.configuration.app_id}&secret=#{Rails.configuration.app_secrete}"
    html_response = nil
    open(uri) do |http|
      html_response = http.read
    end
    access_token = JSON.parse(html_response)["access_token"]
    session["access_token"] = access_token
    render :text =>  access_token
  end

  def get_weixin_ip
    uri = "https://api.weixin.qq.com/cgi-bin/getcallbackip?access_token=#{session["access_token"]}"
    html_response = nil
    open(uri) do |http|
      html_response = http.read
    end
    render :text =>  html_response
  end

  def get_all_user_name
    openids_and_names = []
    uri = "https://api.weixin.qq.com/cgi-bin/user/get?access_token=#{session["access_token"]}&next_openid="
    html_response = nil
    open(uri) do |http|
      html_response = http.read
    end
    open_ids = JSON.parse(html_response)["data"]["openid"][50..100]
    open_ids.each do |openid|
      a = "https://api.weixin.qq.com/cgi-bin/user/info?access_token=#{session["access_token"]}&openid=#{openid}"
      user_info = nil
      open(a) do |http|
        user_info = http.read
      end
      openids_and_names << {openid: openid, name: JSON.parse(user_info)["nickname"]}
    end
    render :text =>  openids_and_names
  end

  def lzj
    render :text => params[:echostr] if params[:echostr]

    # if params[:xml][:MsgType] == "text"
    #   render "lzj", :formats => :xml
    # end
  end
  layout false
  def native
    key = 'ac1a663793021ba50c992c6d76d8390d'
    appid = 'wxf7e700310bb9220f'
    mch_id = '1234542402'
    nonce_str = '5K8264ILTKCH16CQ2502SI8ZNMTM67VS'
    # openid = 'ou9q2sylh21awOVW8VYtL7oC9Sps'
    out_trade_no = '1111'
    product_id = '1'
    spbill_create_ip = '14.23.150.211'
    attach = 'test'
    body = 'test'
    notify_url = 'http://www.baidu.com'
    str = "appid=#{appid}&attach=#{attach}&body=#{body}&mch_id=#{mch_id}&nonce_str=#{nonce_str}&notify_url=#{notify_url}&out_trade_no=#{out_trade_no}&product_id=#{product_id}&spbill_create_ip=#{spbill_create_ip}&total_fee=1&trade_type=NATIVE&key=#{key}"
    sign = Digest::MD5.hexdigest(str).upcase

    xml_content = "
<xml>
   <appid>#{appid}</appid>
   <attach>#{attach}</attach>
   <body>#{body}</body>
   <mch_id>#{mch_id}</mch_id>
   <nonce_str>#{nonce_str}</nonce_str>
   <notify_url>#{notify_url}</notify_url>
   <out_trade_no>#{out_trade_no}</out_trade_no>
   <product_id>#{product_id}</product_id>
   <spbill_create_ip>#{spbill_create_ip}</spbill_create_ip>
   <total_fee>1</total_fee>
   <trade_type>NATIVE</trade_type>
   <sign>#{sign}</sign>
</xml> 
    "

    response = RestClient.post "https://api.mch.weixin.qq.com/pay/unifiedorder", xml_content, :content_type => "text/xml"
    xml_str = response
    xml = Hash.from_xml xml_str
    @code_url = xml["xml"]["code_url"]

    render :text => "error" and return if @code_url.blank?
  end

  def notify_url
    render :text => params
  end

  private
  # 根据参数校验请求是否合法，如果非法返回错误页面
  def check_weixin_legality
    array = [Rails.configuration.weixin_token, params[:timestamp], params[:nonce]].sort
    render :text => "Forbidden", :status => 403 if params[:signature] != Digest::SHA1.hexdigest(array.join)   
  end
  def get_qr_image(qr_code)
    a = 'http://qr.liantu.com/api.php?text=' + qr_code
    res = nil
    open(a) do |http|
      res = http.read
    end
    a
  end
end