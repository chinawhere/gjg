# coding: utf-8
module Twitter
  class API < Grape::API
    version 'v2', using: :header, vendor: 'twitter'
    format :json
    content_type :json, "application/json;charset=utf-8"

    resource :api_events do
      desc "Return events by page and per_page"
      get do
        Event.paginate(page: params[:page] || 1, per_page: params[:per_page] || 10)
      end
    end
  end
end