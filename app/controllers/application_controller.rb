# coding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  before_action :current_user, :check_location, :set_ransack
  helper_method :current_city

  def current_user
    @current_user = User.find(session[:user_id]) if session[:user_id].present?
  end

  def check_location
    gon.city_id = cookies.signed[:city_id]
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
  
  def current_city
    if cookies.signed[:city_id]
      @current_city ||= City.find(cookies.signed[:city_id])
    else
      @current_city = City.first
    end
    @current_city
  end

  def set_ransack
    @q ||= Event.ransack(params[:q])
  end

end
