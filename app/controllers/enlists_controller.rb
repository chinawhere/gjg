#coding: utf-8
class EnlistsController < ApplicationController
  def cert_info
    @enlist = Enlist.find_by_id(params[:id])
    if nil == @enlist
      render text: "对不起， 没有经过认证"
    end
  end
end