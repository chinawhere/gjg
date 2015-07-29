# coding: utf-8
class CommentsController < ApplicationController
  before_action :init_commentable, only: [:index, :create ]
  before_action :require_login, only: [:new, :create, :destroy]

  respond_to :html, :js
  
  def new
    @comment = Comment.new(comment_params)
  end
  
  def index
    p_comments = @commentable.comments.p_comments.includes(:user)
    html_str = render_to_string(:partial => 'comments/comment_list', :locals => { :p_comments => p_comments })
    render text: {success: true, html: html_str}.to_json
  end

  def create
    @comment = @commentable.comments.build comment_params
    @comment.user = current_user
    @comment.save
    @comments = @commentable.comments.lastest
    respond_with(@comment)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy if @comment.user == current_user
    respond_with(@comment)
  end


  private

  def init_commentable
    @commentable = comment_params[:commentable_type].camelize.safe_constantize.find comment_params[:commentable_id]
  end

  def comment_params
    params.require(:comment).permit(:content, :commentable_type, :commentable_id)
  end

end
