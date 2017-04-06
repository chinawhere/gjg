# encoding: utf-8
require "open-uri"  
require "json"
namespace :gensee do
  desc '同步gensee 直播观看记录'
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
        if Gensee.find_by_nickname_and_joinTime(gensee["nickname"],gensee["joinTime"]).blank?
          seeTimeHash = {"see_time" => gensee["leaveTime"] - gensee["joinTime"]}
          Gensee.create!(gensee.merge(hash).merge(seeTimeHash))
        end
      end
    end
  end

  desc '同步gensee 回放观看记录'
  task :playback => :environment do 
    puts "****  同步gensee 回放观看记录  ****"

    uri = "http://fwxgx.gensee.com/integration/site/training/export/study/history?loginName=hhy@126.com&password=123456&date=1491471304000"

    totalPages = get_total_pages(uri)
    puts "    共 #{totalPages} 页"
    for i in 1..totalPages
      puts "-- 当前第 #{i} 页"
      get_playback_record(uri + "&pageNo=#{i}")
    end

  end

  desc '统计用户签到次数'
  task :statistics => :environment do 
    puts "****  统计用户签到次数  ****"

    Enlist.find_each do |enlist|
      # results = Gensee.select("video_id,sum(see_time) as see_times").where("nickname=?",enlist.player.global_id).group("video_id").having("sum(see_time) > ?", 40*60*10000)
      results = Gensee.select("video_id,sum(see_time) as see_times").where("nickname=?",enlist.player.global_id).group("video_id")
      puts "#{enlist.name}  #{results.to_json}"
    end

  end

  def get_total_pages(uri)
    html_response = nil  
    open(uri) do |http|  
      html_response = http.read  
    end  
    json = JSON.parse html_response
    return json["page"]["totalPages"]
  end

  def get_playback_record(uri)
    html_response = nil  
    open(uri) do |http|  
      html_response = http.read  
    end  
    json = JSON.parse html_response

    json["list"].each do |gensee|
      video = Video.find_by_lkey(gensee["id"])
      if video.present?
        hash = {"video_id" => video.id, "mold" => "回放", "sdk" => video.lkey}
        puts gensee
        if Gensee.find_by_nickname_and_joinTime(gensee["name"],gensee["startTime"]).blank?
          seeTimeHash = {"see_time" => gensee["leaveTime"] - gensee["startTime"]}
          one = Gensee.new(hash.merge(seeTimeHash))
          one.uid = gensee["uid"]
          one.ip = gensee["ip"]
          one.name = gensee["name"]
          one.nickname = gensee["name"]
          one.joinTime = gensee["startTime"]
          one.leaveTime= gensee["leaveTime"]
          one.save!
        end    
      end

    end
  end

end