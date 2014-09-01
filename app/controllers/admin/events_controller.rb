# coding: utf-8
class Admin::EventsController < Admin::ApplicationController
  before_filter :load_event, only: [:edit, :update, :destroy]
  def index
    @events = Event.paginate(page: params[:page] || 1, per_page: params[:per_page] || 20)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      redirect_to admin_events_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @event.update_attributes(params[:event])
      redirect_to admin_events_path
    else
      render :edit
    end
  end

  def destroy
    redirect_to admin_events_path if @event.destroy
  end

  private

  def load_event
    @event = Event.find(params[:id])
  end
end