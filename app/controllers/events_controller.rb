#encoding: utf-8
class EventsController < ApplicationController
  before_action :require_login, except: [:index, :show, :photos]
  before_action :load_event, only: [:show, :update, :edit, :destroy, :uploader, :photos]

  respond_to :html
  def index
    @events = @q.result.paginate(page: params[:page] || 1)
  end

  def new
    @taxons = Taxon.select_options
    @event = Event.new
  end

  def create
    puts params
    params.permit!
    @event = @current_user.events.build(params[:event])
    @event.city = current_city
    @event.save!
    puts @event.errors
    respond_with(@event)
  end

  def show
    @event.update_attributes(weight: @event.weight + 1)
    @comments = @event.comments.lastest
  end

  def update
    params.permit!
    @event.update(params[:event])
    respond_with(@event)
  end

  def edit
  end

  def destroy
  end

  def uploader
    # render layout: 'home'
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
