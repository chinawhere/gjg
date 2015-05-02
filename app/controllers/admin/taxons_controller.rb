class Admin::TaxonsController < Admin::ApplicationController

  responders :flash

  respond_to :html

  def index
    @taxons = Taxon.roots
  end

  def new
    @taxon = Taxon.new
  end

  def create
    @taxon = Taxon.new(taxon_params)
    @taxon.save
    respond_with(@taxon, location: admin_taxons_path)
  end

  def edit
    @taxon = Taxon.find(params[:id])
  end

  def update
    @taxon = Taxon.find(params[:id])
    @taxon.update(taxon_params)
    respond_with(@taxon, location: admin_taxons_path)
  end

  def destroy
    @taxon = Taxon.find(params[:id])
    @taxon.destroy
    respond_with(:admin, @taxon)
  end

  def position
    params[:positions].each_with_index do |id, index|
      Taxon.find(id).update_attributes(position: index)
    end
    render json: {status: 0}
  end

  private

  def taxon_params
    params.require(:taxon).permit(:name, :position)
  end

end
