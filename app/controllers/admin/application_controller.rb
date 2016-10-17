# coding: utf-8
class Admin::ApplicationController < ApplicationController
  protect_from_forgery
  before_filter :admin_access_denied

  layout 'admin'

  def admin_access_denied
  	redirect_to admin_login_path and return if session[:staffer_id].blank?
    @current_staffer = User.find(session[:staffer_id])
    redirect_to admin_login_path and return if @current_staffer.blank? || !(@current_staffer.has_role? :admin)
    # redirect_to root_path unless @current_staffer.has_role? :admin
    # redirect_to admin_users_path and return
  end

end
