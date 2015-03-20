class CitiesController < ApplicationController

  def pick
    @city = City.find(params[:id])
    cookies.signed[:city_id] = @city.id
    # redirect_to root_path 
    redirect_to request.referer
  end

end
