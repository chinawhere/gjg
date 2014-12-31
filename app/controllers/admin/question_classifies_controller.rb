# coding: utf-8
class Admin::QuestionClassifiesController < Admin::ApplicationController

  def index
    @question_classifies = QuestionClassify.paginate(page: params[:page] || 1, per_page: params[:per_page] || 20)
  end

  def new
    @question_classify = QuestionClassify.new
  end

  def create
    @question_classify = QuestionClassify.new(params[:question_classify])
    if @question_classify.save
      redirect_to admin_question_classifies_path
    else
      render :new
    end
  end

  def edit
  	@question_classify = QuestionClassify.find(params[:id])
  end

  def update
    if @question_classify.update_attributes(params[:question_classify])
      redirect_to admin_question_classifies_path
    else
      render :edit
    end
  end

  def destroy
    redirect_to admin_question_classifies_path if @question_classify.destroy
  end

end