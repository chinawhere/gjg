# coding: utf-8
class Admin::RolesController < Admin::ApplicationController
  def index
    @roles = Role.all
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new(params[:role])
    if @role.save
      redirect_to admin_roles_path
    else
      render :new
    end
  end

  def edit
    @role = Role.find(params[:id])
  end

  def update
    @role = Role.find(params[:id])
    if @role.update_attributes(params[:role])
      redirect_to admin_roles_path
    else
      render :edit
    end
  end

  def destroy
  end
end