#encoding: utf-8
class EventsController < ApplicationController
  before_filter :require_login, except: [:index, :show]
  before_filter :load_event, only: [:show, :update, :edit, :destroy, :uploader]
  layout 'home'
  def index
    @events = Event.paginate(page: params[:page] || 1, per_page: params[:per_page] || 2)
    photo_ids = @events.map(&:photos_path).compact.join(',').split(',') rescue []
    @photos = Photo.where(id: photo_ids)

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
    photo_ids = @event.photo_ids
    @photos = Photo.where(id: @event.photo_ids) rescue []
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

  def uploader
    @photo = @event.photos.build
  end

  private

  def load_event
    @event = Event.find(params[:id])
  end
end
