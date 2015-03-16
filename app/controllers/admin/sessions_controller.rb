# coding: utf-8
class Admin::SessionsController < Admin::ApplicationController
  skip_before_filter :admin_access_denied, except: [:index, :set_tab]

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
    puts '**********'
    if @user.present?
      puts '2'*100
      session[:staffer_id] = @user.id
      redirect_to admin_root_path
    else
      puts '3'*100
      flash[:notic] = true
      redirect_to admin_login_path
    end
  end

  def set_tab
    session[:tab] = params[:tab]
    render :text => session[:tab]
  end

end