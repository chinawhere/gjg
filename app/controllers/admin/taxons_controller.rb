class Admin::TaxonsController < Admin::ApplicationController

  respond_to :html

  def index
    @taxons = Taxon.roots
  end

  def new
    @taxon = Taxon.new
  end

  def create
    @taxon = Taxon.new(taxon_params)
    flash[:notice] = "创建成功."
    respond_with(:admin, @taxon)
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
