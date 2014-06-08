# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create([{
  name:     '唐玲',
  email:    'qinyan2020@163.com',
  password: '123456',
  sex:      'M',
  mobile:   '18701175667',
  position: 'ruby工程师',
  age:      26,
  qq:       '361771529'
}])

Category.create([{:name=>"运动旅行", :status=>"event"},
                {:name=>"交友聚会", :status=>"event"},
                {:name=>"教育培训", :status=>"event"},
                {:name=>"沙龙讲座", :status=>"event"},
                {:name=>"艺术文化", :status=>"event"},
                {:name=>"消费体验", :status=>"event"},
                {:name=>"会议展览", :status=>"event"},
                {:name=>"社会公益", :status=>"event"},
                {:name=>"其他", :status=>"event"}])
