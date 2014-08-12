#coding: utf-8
class PhotosController < ApplicationController
  def create
    session[:user_id] = params[:user_id]
    photo = Photo.new(params[:photo])
    photo.name = params[:photo][:avatar].original_filename
    if photo.save
      render json: {success: true}.to_json
    else
      render json: {success: false}.to_json
    end
  end

  def destroy  
    @photo = Photo.find(params[:id])  
    @photo.destroy  
    respond_to do |format|  
      format.html { redirect_to event_photos_url(@album.id) }  
      format.json { head :no_content }  
    end  
  end
end
