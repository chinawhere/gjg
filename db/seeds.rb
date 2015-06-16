User.where( name:     '唐玲',
            email:    'qinyan2020@163.com',
            password: '123456',
            sex:      'M',
            mobile:   '18701175667',
            position: 'ruby工程师',
            age:      26,
            qq:       '361771529').first_or_create.add_role :admin
User.where( name:     '夏雷',
            email:    'littlell@126.com',
            password: '88688142',
            sex:      'M',
            mobile:   '18901031876',
            position: 'ruby工程师',
            age:      31,
            qq:       '279596262').first_or_create.add_role :admin


City.find_or_create_by(name: '北京', code:'100000')
City.find_or_create_by(name: '上海', code:'200000')
City.find_or_create_by(name: '广州', code:'510000')
City.find_or_create_by(name: '重庆', code:'630000')


qinzi = Taxon.find_or_create_by(name: '亲子')
qinzi.sub_menus.create!(name: '户外亲子游')
qinzi.sub_menus.create!(name: '亲子运动会')
qinzi.sub_menus.create!(name: '亲子体验')
qinzi.sub_menus.create!(name: '家庭游戏')
qinzi.sub_menus.create!(name: '主题活动')

jiangzuo = Taxon.find_or_create_by(name: '讲座')
jiangzuo.sub_menus.create!(name: '互联网')
jiangzuo.sub_menus.create!(name: '观影会')
jiangzuo.sub_menus.create!(name: '艺术')
jiangzuo.sub_menus.create!(name: '心理')
jiangzuo.sub_menus.create!(name: '文化')
jiangzuo.sub_menus.create!(name: '行业')

zhanlan = Taxon.find_or_create_by(name: '展览')
zhanlan.sub_menus.create!(name: '美术')
zhanlan.sub_menus.create!(name: '图书')
zhanlan.sub_menus.create!(name: '动漫')
zhanlan.sub_menus.create!(name: '摄影')
zhanlan.sub_menus.create!(name: '艺术')
zhanlan.sub_menus.create!(name: '服装')
zhanlan.sub_menus.create!(name: '汽车')
zhanlan.sub_menus.create!(name: '个人')
zhanlan.sub_menus.create!(name: '主题教育')

juhui = Taxon.find_or_create_by(name: '聚会')
juhui.sub_menus.create!(name: '摄影')
juhui.sub_menus.create!(name: '外语')
juhui.sub_menus.create!(name: '桌游')
juhui.sub_menus.create!(name: '交友')
juhui.sub_menus.create!(name: '集市')
juhui.sub_menus.create!(name: '夜店')
juhui.sub_menus.create!(name: '其他')

xiju = Taxon.find_or_create_by(name: '戏剧')
xiju.sub_menus.create!(name: '话剧')
xiju.sub_menus.create!(name: '歌剧')
xiju.sub_menus.create!(name: '舞剧')
xiju.sub_menus.create!(name: '歌舞剧')
xiju.sub_menus.create!(name: '哑剧')

yinyue = Taxon.find_or_create_by(name: '音乐')
yinyue.sub_menus.create!(name: '音乐会')
yinyue.sub_menus.create!(name: '演唱会')
yinyue.sub_menus.create!(name: '音乐节')
yinyue.sub_menus.create!(name: '小型现场')

huwai = Taxon.find_or_create_by(name: '户外健身')
huwai.sub_menus.create!(name: '登山')
huwai.sub_menus.create!(name: '球类')
huwai.sub_menus.create!(name: '跑步')
huwai.sub_menus.create!(name: '骑行')
huwai.sub_menus.create!(name: '舞蹈')
huwai.sub_menus.create!(name: '垂钓')
huwai.sub_menus.create!(name: '攀岩')
huwai.sub_menus.create!(name: '射击')
huwai.sub_menus.create!(name: '滑雪')

lvxing = Taxon.find_or_create_by(name: '旅行')
lvxing.sub_menus.create!(name: '周边游')
lvxing.sub_menus.create!(name: '长途旅行')
