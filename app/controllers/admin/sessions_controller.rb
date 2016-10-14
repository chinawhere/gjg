# coding: utf-8
class Admin::SessionsController < Admin::ApplicationController
  # skip_before_filter :admin_access_denied, except: [:index, :set_tab]
  skip_before_action :admin_access_denied, except: [:index, :set_tab]
  def index
    @user = User.first
  end

  def login
    render layout: false
  end

  def logout
    session[:staffer_id] = nil
    @current_staffer = nil
    redirect_to admin_login_path
  end

  def sessions
    @user = User.where(email: params[:email], password: params[:password]).first
    if @user.present?
      session[:staffer_id] = @user.id
      redirect_to admin_users_path
    else
      flash[:notic] = true
      redirect_to admin_login_path
    end
  end

  def set_tab
    session[:tab] = params[:tab]
    render :text => session[:tab]
  end

end