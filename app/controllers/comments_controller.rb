# coding: utf-8
class CommentsController < ApplicationController
  # skip_before_filter :require_login, :only => [:get_comments]
  # before_filter :require_login
  before_filter :init_commentable, only: [:index, :create]

  def index
    p params
    # p_comments = @commentable.comments.p_comments.includes(:user)

    comments = @commentable.comments.paginate(page: params[:page] || 1, per_page: params[:per_page] || 10)
    html_str = render_to_string(:partial => 'comments/comment_list', :locals => { :comments => comments })
    # render_to_json(:success => true, :html => html_str, :data => { :comments_count => Counter.get_count([@commentable.id], ['comment'])[@commentable.id]['comment']})
    p html_str
    render text: {success: true, html: html_str}.to_json
  end

  def create
    session[:user_id] = params[:current_user_id]
    comment = @commentable.comments.build(
      :content => params[:content], 
      :user_id => params[:current_user_id],
      :p_comment_id => params[:p_comment_id],
      :to_user_id => @commentable.user_id,
      :reply_to_user_id => params[:reply_to_user_id],
      :reply_to_comment_id => params[:reply_to_comment_id]
    )
    render text: {success: false}.to_json and return unless comment.save
    if params[:p_comment_id].blank?
      html_str = render_to_string(:partial => 'comments/comment_list', :locals => { :comments => [comment] })
    else
      html_str = '<div>ok</div>'
      # html_str = render_to_string(:partial => 'comment/reply', :locals => { :comment => comment })
    end
    render text: {success: true, html: html_str}.to_json
  end

  def destroy_comment
    p params
    session[:user_id] = params[:current_user_id]
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
    @commentable = params[:commentable_type].camelize.safe_constantize.find params[:commentable_id]
  end

end
