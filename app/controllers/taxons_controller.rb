class TaxonsController < ApplicationController
	def list
		@taxon = Taxon.find(params[:id])
		@events = @taxon.events.paginate(page: params[:page] || 1, per_page: params[:per_page] || 10)
    photo_ids = []
    @photos = Photo.where(id: photo_ids)
		render template: 'events/index'
	end
end
