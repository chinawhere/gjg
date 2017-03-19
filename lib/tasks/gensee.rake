# encoding: utf-8
require "open-uri"  
require "json"
namespace :gensee do
  desc '同步gensee 观看记录'
  task :sync => :environment do 
    Video.all.each do |video|
      uri = "http://fwxgx.gensee.com/integration/site/training/export/history?roomId=#{video.zkey}&loginName=hhy@126.com&password=123456"  
      html_response = nil  
      open(uri) do |http|  
        html_response = http.read  
      end  
      json = JSON.parse html_response.gsub("\r","-").gsub("\t","-").gsub("\n","-")
      puts json["list"]
      hash = {"video_id" => video.id, "mold" => "直播", "sdk" => video.zkey}
      json["list"].each do |gensee|
        if Gensee.find_by_uid(gensee["uid"]).blank?
          seeTimeHash = {"see_time" => gensee["leaveTime"] - gensee["joinTime"]}
          Gensee.create!(gensee.merge(hash).merge(seeTimeHash))
        end
      end
    end
  end
end