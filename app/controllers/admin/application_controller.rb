# coding: utf-8
class Admin::ApplicationController < ApplicationController
  protect_from_forgery
  before_filter :admin_access_denied

  layout 'admin'

  def admin_access_denied
    @current_staffer = User.find(session[:staffer_id]) rescue nil
    redirect_to admin_login_path and return unless @current_staffer.present?
    redirect_to root_path unless @current_staffer.has_role? :admin
  end

end
