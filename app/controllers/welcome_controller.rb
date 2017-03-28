#coding: utf-8
class WelcomeController < ApplicationController
  def index
    puts request.user_agent
    agent = ""
    if agent == "ie8"
      render "index_ie"
    else
      render "index"
    end
  end

  def info_edit
  	@enlist = current_player.enlist
  	if @enlist.blank?
  		@enlist = Enlist.new(enlist_params)
  		@enlist.training_time = params["training_time"].join("+") if params["training_time"].present?
  		@enlist.save
  	else
  		@enlist.training_time = params["training_time"].join("+") if params["training_time"].present?
  		@enlist.update_attributes(enlist_params)
  	end

    redirect_to root_path
  end

  private
    def enlist_params
      params.permit(:player_id,:name,:qq,:company,:address,:mobile,:mold,:province,:training_time,:skill_one,:skill_two,:sign_number)
    end
end
