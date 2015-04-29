class Admin::SubMenusController < Admin::ApplicationController

  def index
    @taxon = Taxon.find(params[:taxon_id])
    @sub_menus = @taxon.sub_menus
  end

  def new
    @taxon = Taxon.find(params[:taxon_id])
    # @sub_menu = @taxon.sub_menus.build
    @sub_menu = Taxon.new
  end

  def create
    @taxon = Taxon.find(params[:taxon_id])
    @sub_menu = @taxon.sub_menus.new(sub_menu_params)
    if @sub_menu.save
      redirect_to admin_taxon_sub_menus_path(@taxon)
    else
      render :new
    end
  end

  def edit
    @sub_menu = Taxon.find(params[:id])
  end

  def update
    @taxon = Taxon.find(params[:taxon_id])
    @sub_menu = Taxon.find(params[:id])
    if @sub_menu.update(sub_menu_params)
      redirect_to admin_taxon_sub_menus_path(@taxon)
    else
      render :edit
    end
  end

  def destroy
    @taxon = Taxon.find(params[:taxon_id])
    @sub_menu = Taxon.find(params[:id])
    @sub_menu.destroy
    redirect_to admin_taxon_sub_menus_path(@taxon)
  end

  private

  def sub_menu_params
    params.require(:taxon).permit(:name)
  end

end
