#coding: utf-8
class WelcomeController < ApplicationController
  def index
    puts request.user_agent
    if request.user_agent =~ /MSIE 7.0|MSIE 8.0/
      puts "***************  ie 8"
      render "index_new_ie"
    else
      render "index_new"
    end
    # puts request.user_agent
    # if request.user_agent =~ /MSIE 7.0|MSIE 8.0/
    #   puts "***************  ie 8"
    #   render "index_ie"
    # else
    #   render "index"
    # end
  end

  def index_new
    puts request.user_agent
    if request.user_agent =~ /MSIE 7.0|MSIE 8.0/
      puts "***************  ie 8"
      render "index_new_ie", :layout => 'test'
    else
      render "index_new", :layout => 'test'
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
