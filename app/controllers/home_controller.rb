#coding: utf-8
class HomeController < ApplicationController
  before_filter :require_login
  def index
    @events = @current_user.events.paginate(page: params[:page] || 1, per_page: params[:per_page] || 2)
  end
end