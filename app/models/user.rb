# coding: utf-8
class User < ActiveRecord::Base
  rolify
  # validates :email, :presence => { :message => "请填写联系邮箱" }
  # validates :password, :confirmation => true, :presence => { :message => '请填写密码'}
  # validates :name, presence: {message: '输入不能为空'}, uniqueness: {message: '名字已被占用'}
  validates :email, presence: {message: '输入不能为空'}, uniqueness: {message: '邮箱已被占用'}, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, message: '邮箱格式不正确' }
  validates :password, presence: {message: '输入不能为空'}, length: { minimum: 2, maximum: 16, message: '请设置2-16位英文字母、数字、符号密码' }, confirmation: {message: '密码输入不一致'}

  has_many :events
  has_many :applys
  has_many :apply_events, :through => :applys, :source => :event
  mount_uploader :logo, UserLogoUploader

  def display_sex
    self.sex == 'F' ? '女' : '男'
  end
end
