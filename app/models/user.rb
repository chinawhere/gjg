# coding: utf-8
class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :sex, :mobile, :position, :age, :qq
  has_many :events
end
