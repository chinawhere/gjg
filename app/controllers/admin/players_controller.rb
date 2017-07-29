# coding: utf-8
class Admin::PlayersController < Admin::ApplicationController
  def index
    sql = ""
    sql = " and username like '%#{params[:username]}%' " if params[:username].present?
    sql = " and mobile like '%#{params[:mobile]}%' " if params[:mobile].present?
    sql = " and email like '%#{params[:email]}%' " if params[:email].present?
    sql = " and mobile like '%#{params[:mobile]}%' " if params[:mobile].present?
    sql = " and sign_number like '%#{params[:sign_number]}%' " if params[:sign_number].present?
    puts params
    @enlists = Player.where("id > 0 #{sql}").order("created_at desc").paginate(page: params[:page] || 1, per_page: params[:per_page] || 20)
    #@enlists = Player.order("created_at desc").paginate(page: params[:page] || 1, per_page: params[:per_page] || 20)
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

  def export_csv
    send_data(Player.to_csv.encode("gb18030"), :type => 'text/csv', :filename => "用户表.csv")
  end

  private
    def enlist_params
      params.require(:enlist).permit(:global_id,:email,:mobile,:username,:sex)
    end
end
