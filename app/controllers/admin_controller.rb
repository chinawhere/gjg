# coding: utf-8
class AdminController < ApplicationController
  def index
    @user = User.first
  end
end
