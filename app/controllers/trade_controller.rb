require 'open-uri'
require 'rest_client'
class TradeController < ApplicationController
	skip_before_filter :verify_authenticity_token
	before_filter :check_weixin_legality, only: ['lzj']
  def index
  	render :text => "index"
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

  def erweima
    
    appid = 'wxf7e700310bb9220f'
    mch_id = '1234542402'
    # nonce_str = SecureRandom.hex(20)
    nonce_str = '5K8264ILTKCH16CQ2502SI8ZNMTM67VS'
    product_id = 1
    time_stamp = Time.now.to_i
    key = 'ac1a663793021ba50c992c6d76d8390d'
    str = "appid=#{appid}&mch_id=#{mch_id}&nonce_str=#{nonce_str}&product_id=#{product_id}&time_stamp=#{time_stamp}&key=#{key}"
    sign = Digest::MD5.hexdigest(str).upcase 

    @qr_code = "weixin://wxpay/bizpayurl?appid=#{appid}&mch_id=#{mch_id}&nonce_str=#{nonce_str}&product_id=#{product_id}&time_stamp=#{time_stamp}&sign=#{sign}"
    # @qr_image = get_qr_image(@qr_code)
    # redirect_to @qr_image
    render :text => @qr_code
  end

  def native
    key = 'ac1a663793021ba50c992c6d76d8390d'
    appid = 'wxf7e700310bb9220f'
    @appid = appid
    mch_id = '1234542402'
    @mch_id = mch_id
    nonce_str = '5K8264ILTKCH16CQ2502SI8ZNMTM67VS'
    @nonce_str = nonce_str
    notify_url = 'https://blooming-waters-9993.herokuapp.com/weixins/notify_url'
    openid = 'ou9q2sylh21awOVW8VYtL7oC9Sps'
    #openid = params[:xml][:openid]
    out_trade_no = '12345'
    product_id = '1'
    spbill_create_ip = '14.23.150.211'
    attach = 'test'
    body = 'test'
    str = "appid=#{appid}&attach=#{attach}&body=#{body}&mch_id=#{mch_id}&nonce_str=#{nonce_str}&notify_url=#{notify_url}&openid=#{openid}&out_trade_no=#{out_trade_no}&product_id=#{product_id}&spbill_create_ip=#{spbill_create_ip}&total_fee=1&trade_type=NATIVE&key=#{key}"
    sign = Digest::MD5.hexdigest(str).upcase

#     xml_content = '
# <xml>
#   <appid>wxf7e700310bb9220f</appid>
#   <attach>test</attach>
#   <body>test</body>
#   <mch_id>1234542402</mch_id>
#   <nonce_str>SHfpUuq8K4xEfeff</nonce_str>
#   <notify_url>https://blooming-waters-9993.herokuapp.com/weixins/notify_url</notify_url>
#   <openid>ou9q2sylh21awOVW8VYtL7oC9Sps</openid>
#   <out_trade_no>12345</out_trade_no>
#   <product_id>1</product_id>
#   <spbill_create_ip>14.23.150.211</spbill_create_ip>
#   <total_fee>1</total_fee>
#   <trade_type>NATIVE</trade_type>
#   <sign>56C81AEEAA350431D4123B6FF1E61B8E</sign>
# </xml>
#     '

    xml_content = "
<xml>
   <appid>#{appid}</appid>
   <attach>#{attach}</attach>
   <body>#{body}</body>
   <mch_id>#{mch_id}</mch_id>
   <nonce_str>#{nonce_str}</nonce_str>
   <notify_url>https://blooming-waters-9993.herokuapp.com/weixins/notify_url</notify_url>
   <openid>#{openid}</openid>
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
    @prepay_id = response["xml"]["prepay_id"]
    Log.create(content: @prepay_id)
    str = "appid=#{appid}&mch_id=#{mch_id}&nonce_str=#{nonce_str}&prepay_id=@prepay_id&result_code=SUCCESS&return_code=SUCCESS&key=#{key}"
    @sign = Digest::MD5.hexdigest(str).upcase
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