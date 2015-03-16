#coding: utf-8
class PhotosController < ApplicationController

  def create
    params.permit!
    session[:user_id] = params[:user_id]
    photo = Photo.new(params[:photo])
    photo.name = params[:photo][:avatar].original_filename
    if photo.save
      render json: {success: true, thumbnail_url: photo.avatar_url}.to_json
    else
      render json: {success: false}.to_json
    end
  end

  def destroy  
    @photo = Photo.find(params[:id])
    @photo.destroy  
    redirect_to events_path
  end

  def show_original
    @photo = Photo.find(params[:id])
    render :layout => false
  end

  def recommend
    @photo = Photo.find(params[:id])
    @photo.recommend_event_photos
    redirect_to :back
  end

end
