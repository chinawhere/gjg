desc '载入活动测试数据'
task :load_events => :environment do
  100.times do |i|
    event = Event.new(name: "活动#{i}", address: "地址#{i}", fee_type: 1, fee: 10, max_count: 10, min_count: 1, content: "内容#{i}", start_at: Time.now, end_at: Time.now + 24 * 60 * 60)
    event.user = User.last
    event.taxon = Taxon.first
    event.city = City.all.sample
    event.save
  end
  100.times do |i|
    event = Event.new(name: "活动#{i}", address: "地址#{i}", fee_type: 1, fee: 10, max_count: 10, min_count: 1, content: "内容#{i}", start_at: Time.now - 30 * 24 * 60 * 60 - 24 * 60 * 60, end_at: Time.now - 30 * 24 * 60 * 60)
    event.user = User.last
    event.taxon = Taxon.first
    event.city = City.all.sample
    event.save
  end
  100.times do |i|
    event = Event.new(name: "活动#{i+100}", address: "地址#{i+100}", fee_type: 1, fee: 10, max_count: 10, min_count: 1, content: "内容#{i}", start_at: Time.now  + 30 * 24 * 60 * 60, end_at: Time.now  + 30 * 24 * 60 * 60 + 24 * 60 * 60)
    event.user = User.last
    event.taxon = Taxon.first
    event.city = City.all.sample
    event.save
  end
end
