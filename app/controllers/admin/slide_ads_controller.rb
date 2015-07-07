class Admin::SlideAdsController < Admin::ApplicationController
	respond_to :html
	before_action :find_slide_ad, only: [:destroy, :edit, :update]
	def index
		respond_with(@slide_ads = SlideAd.all)
	end
	def new
		respond_with(@slide_ad = SlideAd.new)
	end
	def create
		@slide_ad = SlideAd.create(slide_ad_params)
		respond_with @slide_ad, location: admin_slide_ads_path
	end
	def destroy
		@slide_ad.destroy
		respond_with @slide_ad, location: admin_slide_ads_path
	end
	def edit
	end
	def update
		@slide_ad.update_attributes(slide_ad_params)
		respond_with @slide_ad, location: admin_slide_ads_path
	end

	private
	def slide_ad_params
		params.require(:slide_ad).permit(:title, :link, :img)
	end
	def find_slide_ad
		@slide_ad = SlideAd.find(params[:id])
	end
end
