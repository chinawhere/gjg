# coding: utf-8
class Admin::PlayersController < Admin::ApplicationController
  def index
    @enlists = Player.paginate(page: params[:page] || 1, per_page: params[:per_page] || 20)
  end

  def new
    @enlist = Player.new
  end

  def create
    @enlist = Player.new(enlist_params)
    if @enlist.save
      redirect_to admin_players_path
    else
      render :new
    end
  end

  def edit
    @enlist = Player.find(params[:id])
  end

  def update
    @enlist = Player.find(params[:id])
    if @enlist.update_attributes(enlist_params)
      redirect_to admin_players_path
    else
      render :edit
    end
  end

  def destroy
    @enlist = Player.find(params[:id])
    redirect_to admin_players_path if @enlist.destroy
  end

  private
    def enlist_params
      params.require(:enlist).permit(:global_id,:email,:mobile,:username,:sex)
    end
end