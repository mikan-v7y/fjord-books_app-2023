class CommentsController < ApplicationController
  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @commentable, notice: "コメントを投稿しました"
    else
      redirect_to @commentable, alert: "コメントの投稿に失敗しました"
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
      redirect_to @commentable, notice: "コメントを更新しました。"
    else
      redirect_to @commentable, alert: "コメントの更新に失敗しました"
    end
  end

  def destroy
    @comment.destroy
    redirect_to @comment.commentable, notice: "コメントを削除しました"
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
