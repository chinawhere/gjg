#coding: utf-8
class HomeController < ApplicationController
  def index
  end

  def login
  end

  def sessions
    user = User.where(email: params[:email], password: params[:password]).first
    if user.present?
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:notice] = true
      render :login
    end
  end

  def register
  end

  def sign_up
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:notice] = @user.errors.messages.values.join(',')
      render :register
    end
  end

  def logout
    session[:user_id] = nil
    @current_user = nil
    redirect_to root_path
  end
end