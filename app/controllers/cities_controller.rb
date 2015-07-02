class CitiesController < ApplicationController

  def pick
    @city = City.find(params[:id])
	  @events = Event.where("city_code= ? and start_at > ?", @city.code,  Time.now).limit(8)
    cookies.signed[:city_id] = @city.id
  end

end
