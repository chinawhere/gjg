class TaxonsController < ApplicationController
	def list
		puts params
		@taxon = Taxon.find(params[:id]) if params[:id].present?
	    if @taxon
	    	puts "a" * 100
	      @events = @taxon.events.paginate(page: params[:page] || 1, per_page: params[:per_page] || 10)
	    else
	    	puts "b" * 100
	      @events = Event.all.paginate(page: params[:page] || 1, per_page: params[:per_page] || 10)
	    end
		render template: 'events/index'
	end
end
