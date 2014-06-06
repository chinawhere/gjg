class EventsController < ApplicationController
  before_filter :load_user, only: [:create, :update]
  def index
  end

  def new
    @event = Event.new
  end

  def create
    @events = @current_user.events.build(params[:events])
    if @events.save
      redirect_to events_path
    else
      render :new
    end

  end

  def update
  end

  def edit
  end

  private

  def load_user
    @current_user = User.first
  end
end
