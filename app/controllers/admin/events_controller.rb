# coding: utf-8
class Admin::EventsController < Admin::ApplicationController
  def index
    @events = Video.paginate(page: params[:page] || 1, per_page: params[:per_page] || 20)
  end

  def new
    @event = Video.new
  end

  def create
    @event = Video.new(video_params)
    if @event.save
      redirect_to admin_events_path
    else
      render :new
    end
  end

  def edit
    @event = Video.find(params[:id])
  end

  def update
    @event = Video.find(params[:id])
    if @event.update_attributes(video_params)
      redirect_to admin_events_path
    else
      render :edit
    end
  end

  def destroy
    @event = Video.find(params[:id])
    redirect_to admin_events_path if @event.destroy
  end

  private
    def video_params
      params.require(:event).permit(:name, :zkey,:zurl,:lkey,:lurl)
    end
end