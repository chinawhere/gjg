User.where( name:     'admin',
            email:    'admin@163.com',
            password: '123456',
            sex:      'M',
            mobile:   '15000000000',
            position: '管理员',
            age:      1,
            qq:       '666666666').first_or_create.add_role :admin

