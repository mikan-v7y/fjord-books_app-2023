# frozen_string_literal: true

module Books
  class CommentsController < ApplicationController
    before_action :set_book
    before_action :set_comment, only: [:edit, :update, :destroy]

    def create
      @comment = @book.comments.build(comment_params)
      @comment.user = current_user

      if @comment.save
        redirect_to @book, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
      else
        redirect_to @book, alert: t('controllers.comments.notice_create_failure', name: Comment.model_name.human)
      end
    end

    def edit; end

    def update
      if @comment.update(comment_params)
        redirect_to @book, notice: t('controllers.common.notice_update', name: Comment.model_name.human)
      else
        redirect_to @book, alert: t('controllers.common.notice_update_failure', name: Comment.model_name.human)
      end
    end

    def destroy
      @comment.destroy
      redirect_to @book, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
    end

    private

    def set_book
      @book = Book.find(params[:book_id])
    end

    def set_comment
      @comment = @book.comments.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:content)
    end

    def set_commentable
      @commentable = @book
    end
  end
end
