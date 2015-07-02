#coding: utf-8
class HomeController < ApplicationController
  before_filter :require_login
  def index
    @events = @current_user.events.paginate(page: params[:page] || 1, per_page: params[:per_page] || 3)
    @apply_events = @current_user.apply_events.paginate(page: params[:page] || 1, per_page: params[:per_page] || 3)
    photo_ids = (@events+@apply_events).map(&:photos_path).compact.join(',').split(',') rescue []
    # photo_ids << @apply_events
    @photos = Photo.where(id: photo_ids)
  end
end
