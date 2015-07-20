# coding: utf-8
class CommentsController < ApplicationController
  # skip_before_filter :require_login, :only => [:get_comments]
  # before_filter :require_login
  before_action :init_commentable, only: [:index, :create]
  before_action :require_login, only: [:new, :create, :destroy_comment]

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
    @comments = Comment.lastest
    respond_with(@comment)
  end

  def destroy_comment
    session[:user_id] = params[:current_user_id]
    @current_user = User.find(session[:user_id])
    comment = Comment.find params[:comment_id]
    user_id = params[:current_user_id].to_i
    if user_id == comment.user_id || user_id == comment.commentable.user_id
      comment.destroy
      render text: {success: true}.to_json
    else
      render text: {success: false}.to_json
    end
  end

  private

  def init_commentable
    @commentable = comment_params[:commentable_type].camelize.safe_constantize.find comment_params[:commentable_id]
  end

  def comment_params
    params.require(:comment).permit(:content, :commentable_type, :commentable_id)
  end

end
