class TaxonsController < ApplicationController
	def list
		@taxon = Taxon.find(params[:id]) if params[:id].present?
    if @taxon.parent.present?
      @events = @taxon.events.paginate(page: params[:page] || 1, per_page: params[:per_page] || 10)
    else
      @events = Event.where(category_id: @taxon.sub_menus.map(&:id)).paginate(page: params[:page] || 1, per_page: params[:per_page] || 10)
    end
		render template: 'events/index'
	end
end
