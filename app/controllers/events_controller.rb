#encoding: utf-8
class EventsController < ApplicationController
  before_filter :require_login, except: [:index, :show, :photos]
  before_filter :load_event, only: [:show, :update, :edit, :destroy, :uploader, :photos]
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
  end

  def photos
    @photo = Photo.find(params[:p_id]) rescue @event.photos.first
    @previous_photo = @photo.previous_photo
    @next_photo = @photo.next_photo
  end

  #活动日历
  def calendar
   render json: Event.events_calendar.to_json
  end

  def apply_event
    Apply.where(:user_id => @current_user.id,:event_id => params[:id]).first_or_create
    redirect_to :back
  end

  def not_apply_event
    apply = Apply.where(:user_id => @current_user.id,:event_id => params[:id]).first
    apply.delete if apply.present?
    redirect_to :back
  end

  private

  def load_event
    @event = Event.find(params[:id])
  end
end
