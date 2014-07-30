# coding: utf-8
class AdminController < ApplicationController
  def index
    @user = User.first
  end

  def login
    render layout: false
  end

  def sessions
  end
end
