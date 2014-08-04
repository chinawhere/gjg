#encoding: utf-8
class EventsController < ApplicationController
  before_filter :require_login, except: [:index, :show]
  before_filter :load_event, only: [:show, :update, :edit, :destroy]
  layout 'home'
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
  end

  def update
    if @event.update_attributes(params[:event])
      redirect_to events_path
    else
      render :edit
    end
        
  end

  def edit
  end

  def destroy
  end

  private

  def load_user
    @event = Event.find(params[:id])
  end
end
