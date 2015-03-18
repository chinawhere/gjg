# coding: utf-8
class SettingController < ApplicationController
  before_filter :require_login
  layout 'home'
  def account
  end

  def basic
    params.permit!
    if @current_user.update_attributes(params[:user])
      redirect_to account_settings_path
    else
      render :account
    end
  end

  def password
  end

end