# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :given_mentions, class_name: 'Mention', foreign_key: 'source_report_id'
  has_many :mentioning_reports, through: :given_mentions, source: :target_report

  has_many :received_mentions, class_name 'Mention', foreign_key: 'target_report_id'
  has_many: mentioned_reports, through: :received_mentions, source: :source_report

  validates :title, presence: true
  validates :content, presence: true

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  # 引数のreportは、これから作成or更新されるReportオブジェクト
  def detect_report_url_and_update_mentions(report)
    # content内のURLからreport_idを検知し、変数に格納（例: /reports/1）
    mentioned_report_ids = report.content.scan(%r{http://localhost:3000/reports/(\d+)}).flatten.map(&:to_i)

    # source_report_id（言及元のid）がこのreport.idと同じ場合、mentionsテーブルからそのレコードを削除
    report.given_mentions.destroy_all

    # 新しいMentionのレコードを作成
    mentioned_report_ids.uniq.each do |target_id| # 配列内に言及先の日報のidが2つ以上存在する場合、uniqメソッドで1つにする
      next if target_id == report.id  # 自己言及は不自然なのでスキップ（日報内で自分を言及するのは不自然）
      Mention.create(source_report_id: report.id, target_report_id: target_id)
    end
  end
end
