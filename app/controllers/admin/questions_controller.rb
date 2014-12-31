# coding: utf-8
class Admin::QuestionsController < Admin::ApplicationController
  def index
    @questions = Question.paginate(page: params[:page] || 1, per_page: params[:per_page] || 20)
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(params[:question])
    if @question.save
      redirect_to admin_questions_path
    else
      render :new
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update_attributes(params[:question])
      redirect_to admin_questions_path
    else
      render :edit
    end
  end

  def destroy
  end
end