# coding: utf-8
class Admin::GenseesController < Admin::ApplicationController
  def index
    @enlists = Gensee.paginate(page: params[:page] || 1, per_page: params[:per_page] || 10)
  end

  private
    def enlist_params
      params.require(:enlist).permit(:uid,:area,:see_time,:company,:joinTime,:leaveTime,:nickname,:mobile,:device,:ip,:name,:video_id,:mold,:sdk)
    end
end