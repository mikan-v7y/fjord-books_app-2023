class CommentsController < ApplicationController
  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      redirect_to @commentable, alert: t('controllers.comments.notice_create_failure', name: Comment.model_name.human)
    end
  end

  before_action :set_comment, only: [:destroy]

  def edit
    @commentable = find_commentable
    @comment = @commentable.comments.find(params[:id])
  end

  def update
    @commentable = find_commentable
    @comment = @commentable.comments.find(params[:id])

    if @comment.update(comment_params)
      redirect_to @commentable, notice: t('controllers.common.notice_update', name: Comment.model_name.human)
    else
      redirect_to @commentable, alert: t('controllers.common.notice_update_failure', name: Comment.model_name.human)
    end
  end

  def destroy
    @comment.destroy
    redirect_to @comment.commentable, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def find_commentable
    if params[:book_id]
      Book.find(params[:book_id])
    elsif params[:report_id]
      Report.find(params[:report_id])
    else
      nil
    end
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
