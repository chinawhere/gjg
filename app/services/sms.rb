# -*- encoding : utf-8 -*-
# To change this template, choose Tools | Templates
# and open the template in the editor.

class Sms
  require "soap/wsdlDriver"

  def self.send_message mobileNumber, text
    wsdl = "http://sms.glodon.com/SMSService.asmx" + "?WSDL"
    driver = SOAP::WSDLDriverFactory.new(wsdl).create_rpc_driver
    p driver
    ret = driver.SendSms(:mobile => mobileNumber, :text => text, :username => 'wlyx', :password => '201105201325').__xmlele[0][1]
    ret.is_a?(String) ? ret : nil
  end
end
