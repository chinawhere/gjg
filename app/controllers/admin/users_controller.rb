# coding: utf-8
class Admin::UsersController < Admin::ApplicationController

  def index
    @user = User.first
    @users = User.paginate(page: params[:page] || 1, per_page: params[:per_page] || 20)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    redirect_to admin_users_path if @user.destroy
  end

end