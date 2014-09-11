#source 'https://rubygems.org'
source 'http://ruby.taobao.org'

if RUBY_VERSION =~ /1.9/

  Encoding.default_external = Encoding::UTF_8

  Encoding.default_internal = Encoding::UTF_8

end

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

#副文本
# gem 'ckeditor'
gem 'rails_kindeditor'

# css
# gem "twitter-bootstrap-rails"
gem 'bootstrap3-rails'

# 文件和图片处理
gem 'carrierwave'
gem 'mini_magick'
gem 'piet'

#权限管理
gem "rolify"

# 分页
gem 'will_paginate'

#时间
# gem 'bootstrap-datetimepicker-rails'

gem 'sqlite3'

# group :development, :test do
#   gem 'sqlite3'
# end

group :production do
  gem 'pg'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
# gem 'unicorn'
group :development do
  gem 'capistrano', "~> 2.11.0"
  gem "net-ssh", "~> 2.7.0"
end

# gem 'capistrano-rbenv'
gem 'activeadmin'

gem 'mina'
gem 'puma'

gem 'grape'
gem 'grape-swagger'

gem 'mysql2'
gem 'faraday'
