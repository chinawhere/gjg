# coding: utf-8
class Admin::SessionsController < Admin::ApplicationController
  skip_before_filter :admin_access_denied, except: [:index]

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
    @user = User.where(name: params[:name], password: params[:password]).first
    if @user.present?
      session[:staffer_id] = @user.id
      redirect_to admin_root_path
    else
      flash[:notic] = true
      redirect_to admin_login_path
    end
  end

end