#encoding: utf-8
class EventsController < ApplicationController
  before_filter :require_login, except: [:index, :show, :photos]
  before_filter :load_event, only: [:show, :update, :edit, :destroy, :uploader, :photos]

  respond_to :html
  def index
    @events = Event.search(params).paginate(page: params[:page] || 1, per_page: params[:per_page] || 10)
    photo_ids = @events.map(&:photos_path).compact.join(',').split(',') rescue []
    @photos = Photo.where(id: photo_ids)
  end

  def new
    @taxons = Taxon.select_options
    @event = Event.new
  end

  def create
    params.permit!
    @event = @current_user.events.build(params[:event])
    @event.save
    respond_with(@event, location: events_path)
  end

  def show
  end

  def update
    params.permit!
    @event.update(params[:event])
    respond_with(@event, location: events_path)
  end

  def edit
  end

  def destroy
  end

  def uploader
    render layout: 'home'
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
