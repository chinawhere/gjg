#encoding: utf-8
class EventsController < ApplicationController
  before_filter :load_user, only: [:create, :update]
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @events = @current_user.events.build(params[:event])
    if @events.save
      redirect_to events_path
    else
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      redirect_to events_path
    else
      render :edit
    end
        
  end

  def edit
    @event = Event.find(params[:id])
  end

  private

  def load_user
    @current_user = User.first
  end
end
