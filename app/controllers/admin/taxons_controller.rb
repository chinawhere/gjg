class Admin::TaxonsController < Admin::ApplicationController

  def index
    @taxons = Taxon.roots
  end

  def new
    @taxon = Taxon.new
  end

  def create
    @taxon = Taxon.new(taxon_params)
    if @taxon.save
      redirect_to admin_taxons_path
    else
      render :new
    end
  end

  def edit
    @taxon = Taxon.find(params[:id])
  end

  def update
    @taxon = Taxon.find(params[:id])
    if @taxon.update(taxon_params)
      redirect_to admin_taxons_path
    else
      render :edit
    end
  end

  def destroy
    @taxon = Taxon.find(params[:id])
    @taxon.destroy
    redirect_to admin_taxons_path
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
