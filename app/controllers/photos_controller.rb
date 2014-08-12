#coding: utf-8
class PhotosController < ApplicationController
  def create
    photo = Photo.new(params[:photo])
    respond_to do |format|
      if photo.save  
        format.html {  
          render :json => [photo.to_json_picture].to_json,  
          :content_type => 'text/html',  
          :layout => false  
        }  
        format.json { render json: {files: [photo.to_json_picture]}, status: :created, location: album_photo_url(@album.id, photo.id) }  
      else
        p photo.errors 
        format.html { render action: "new" }  
        format.json { render json: photo.errors, status: :unprocessable_entity }  
      end  
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
