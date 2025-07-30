# frozen_string_literal: true

module Reports
  class CommentsController < ApplicationController
    before_action :set_report
    before_action :set_comment, only: %i[edit update destroy]

    def create
      @comment = current_user.comments.build(commentable: @report, **comment_params)

      if @comment.save
        redirect_to @report, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
      else
        redirect_to @report, alert: t('controllers.comments.notice_create_failure', name: Comment.model_name.human)
      end
    end

    def edit; end

    def update
      if @comment.update(comment_params)
        redirect_to @report, notice: t('controllers.common.notice_update', name: Comment.model_name.human)
      else
        redirect_to @report, alert: t('controllers.common.notice_update_failure', name: Comment.model_name.human)
      end
    end

    def destroy
      @comment.destroy
      redirect_to @report, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
    end

    private

    def set_report
      @report = Report.find(params[:report_id])
    end

    def set_comment
      @comment = @report.comments.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:content)
    end
  end
end
