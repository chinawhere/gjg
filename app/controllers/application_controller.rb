# coding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :current_user

  def current_user
    @current_user = User.find(session[:user_id]) if session[:user_id].present?
  end

  def require_login
    redirect_to login_path unless @current_user and session[:user_id]
  end
end
