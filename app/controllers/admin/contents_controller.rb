# coding: utf-8
class Admin::ContentsController < Admin::ApplicationController
  def index
    @contents = Content.all
  end

  def new
  end

  def create
	  @content = Content.find_by_type(params[:type])
	  if nil != @content
		  @content.update_attributes(content: params[:content])
	  end
	  redirect_to admin_contents_path
  end

  def edit
	  @content = Content.find(params[:id])
  end

  def update
    @content = Content.find(params[:id])
    @content.update_attributes(content_params)
    redirect_to admin_contents_path
  end

  def destroy
    @enlist = Content.find(params[:id])
    redirect_to admin_players_path if @enlist.destroy
  end

  private
    def content_params
      params.require(:content).permit(:id,:ctype,:content)
    end
end
