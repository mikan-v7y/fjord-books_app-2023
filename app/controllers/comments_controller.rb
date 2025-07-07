class CommentsController < ApplicationController
  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(comment_params)

    if @comment.save
      redirect_to @commentable, notice: "コメントを投稿しました"
    else
      redirect_to @commentable, alert: "コメントの投稿に失敗しました"
    end
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
end
