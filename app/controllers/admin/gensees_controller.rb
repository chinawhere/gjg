# coding: utf-8
class Admin::GenseesController < Admin::ApplicationController
  def index
    @enlists = Gensee.where("nickname like '%#{params[:nickname]}%' and video_id like '%#{params[:video_id]}%'").order("joinTime desc").paginate(page: params[:page] || 1, per_page: params[:per_page] || 20)
    @total_count = Gensee.where("nickname like '%#{params[:nickname]}%' and video_id like '%#{params[:video_id]}%'").order("joinTime desc").group(:nickname).length
  end

  def export_csv
    send_data(Gensee.to_csv.encode("gb18030"), :type => 'text/csv', :filename => "观看记录.csv")
  end

  private
    def enlist_params
      params.require(:enlist).permit(:uid,:area,:see_time,:company,:joinTime,:leaveTime,:nickname,:mobile,:device,:ip,:name,:video_id,:mold,:sdk)
    end
end
