#coding: utf-8
class SessionsController < ApplicationController

  def login
  end

  def sessions
    user = User.where(email: params[:email], password: params[:password]).first
    if user.present?
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash.now[:notice] = true
      render :login
    end
  end

  def register
    @user ||= User.new
  end

  def sign_up
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash.now[:notice] = @user.errors.messages.values.join(',')
      render :register
    end
  end

  def logout
    session[:user_id] = nil
    @current_user = nil
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
