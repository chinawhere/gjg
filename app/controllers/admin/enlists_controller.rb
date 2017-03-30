# coding: utf-8
class Admin::EnlistsController < Admin::ApplicationController
  def index
    sql = ""
    sql = " and skill_one = 'true' " if params[:skill_one].present?
    sql = " and skill_two = 'true' " if params[:skill_two].present?
    puts params
    @enlists = Enlist.where("province like '%#{params[:province]}%' and training_time like '%#{params[:training_time]}%' and sign_number like '%#{params[:sign_number]}%' #{sql}").order("created_at desc").paginate(page: params[:page] || 1, per_page: params[:per_page] || 20)
  end

  def new
    @enlist = Enlist.new
  end

  def create
    @enlist = Enlist.new(enlist_params)
    if @enlist.save
      redirect_to admin_enlists_path
    else
      render :new
    end
  end

  def edit
    @enlist = Enlist.find(params[:id])
  end

  def update
    @enlist = Enlist.find(params[:id])
    if @enlist.update_attributes(enlist_params)
      redirect_to admin_enlists_path
    else
      render :edit
    end
  end

  def destroy
    @enlist = Enlist.find(params[:id])
    redirect_to admin_enlists_path if @enlist.destroy
  end

  def export_csv
    # @enlists = Enlist.all

    send_data("\xEF\xBB\xBF" << Enlist.to_csv, :type => 'text/csv', :filename => "报名表.csv")    
  end

  def auditing_one
    @enlist = Enlist.find(params[:id])
    @enlist.skill_one = true
    @enlist.save!
    redirect_to :back
  end

  def auditing_two
    @enlist = Enlist.find(params[:id])
    @enlist.skill_two = true
    @enlist.save!
    redirect_to :back
  end

  private
    def enlist_params
      params.require(:enlist).permit(:player_id,:name,:qq,:company,:address,:mobile,:mold,:province,:training_time,:skill_one,:skill_two,:sign_number)
    end
end