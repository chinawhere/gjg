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

  def set_login_state(user)
    session[:user_id] = user.id
    @current_user = user
  end

  def set_current_user
    if !cookies.signed[:_cw_al].blank? && session[:user_id].blank?
      sp = cookies.signed[:_cw_al].split(';')
      (sp[0].to_i + 2.weeks.to_i > Time.now.to_i) ? session[:user_id] = sp[1] : clear_auto_login
    end
    @current_user = (User.find session[:user_id] rescue nil) if session[:user_id]
  end

  def clear_login_state
    session[:user_id] = nil
    @current_user = nil
  end
end
