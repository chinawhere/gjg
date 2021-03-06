# encoding: utf-8
require "open-uri"  
require "json"
namespace :gensee do
  desc '同步gensee 直播观看记录'
  task :sync => :environment do 
    while true
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

      sleep 6
    end

  end

  desc '历史gensee 回放观看记录'
  task :history => :environment do 
    (1...20).to_a.each  do |i|
      puts "****  同步gensee 回放观看记录  ****"
      time_sec = (Time.now.to_i - i*24*60*60)*1000
      uri = "http://fwxgx.gensee.com/integration/site/training/export/study/history?loginName=hhy@126.com&password=123456&date=#{time_sec}"

      totalPages = get_total_pages(uri)
      puts "    共 #{totalPages} 页"
      for i in 1..totalPages
        puts "-- 当前第 #{i} 页"
        get_playback_record(uri + "&pageNo=#{i}")
      end 
      
      sleep 6
    end
  end

  desc '同步gensee 回放观看记录'
  task :playback => :environment do 
    while true
      puts "****  同步gensee 回放观看记录  ****"
      time_sec = (Time.now.to_i)*1000
      uri = "http://fwxgx.gensee.com/integration/site/training/export/study/history?loginName=hhy@126.com&password=123456&date=#{time_sec}"

      totalPages = get_total_pages(uri)
      puts "    共 #{totalPages} 页"
      for i in 1..totalPages
        puts "-- 当前第 #{i} 页"
        get_playback_record(uri + "&pageNo=#{i}")
      end 
      
      sleep 6  
    end
  end

  desc '统计用户签到次数'
  task :statistics => :environment do 
    while true
      puts "****  统计用户签到次数  ****"

      Player.find_each do |player|
        # results = Gensee.select("video_id,sum(see_time) as see_times").where("nickname=?",enlist.player.global_id).group("video_id").having("sum(see_time) > ?", 40*60*10000)
        #  num = Gensee.where("nickname=?",enlist.player.global_id).select("video_id,sum(see_time) as see_times").group("video_id").having("sum(see_time) > ?", 40*60*1000).length

        results = Gensee.where("nickname=?",player.global_id).group("video_id").having("sum(see_time) > ?", 40*60*1000).sum(:see_time)

        if results.count > 0
          puts "#{player.id}  #{results}   #{results.count}"
          player.sign_number = results.count
          player.save!

          enlist = player.enlist
          if enlist.present?
            enlist.sign_number = results.count
            enlist.save!
          end
        end
      end 
      sleep 6      
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
        # puts gensee
        @gensee = Gensee.find_by_nickname_and_joinTime(gensee["name"],gensee["startTime"])
        if @gensee.blank?
          seeTimeHash = {"see_time" => gensee["leaveTime"] - gensee["startTime"]}
          one = Gensee.new(hash.merge(seeTimeHash))
          one.uid = gensee["uid"]
          one.ip = gensee["ip"]
          one.name = gensee["name"]
          one.nickname = gensee["name"]
          one.joinTime = gensee["startTime"]
          one.leaveTime= gensee["leaveTime"]
          one.save!
        else
          seeTimeHash = {"see_time" => gensee["leaveTime"] - gensee["startTime"]}
          puts "观看时间：" + (seeTimeHash["see_time"]* 0.001 /60).round(1).to_s

          @gensee.joinTime = gensee["startTime"]
          @gensee.leaveTime= gensee["leaveTime"]
          @gensee.see_time= seeTimeHash["see_time"]
          @gensee.save! 
        end    
      end

    end
  end

end