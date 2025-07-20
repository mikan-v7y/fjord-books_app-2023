# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :given_mentions, class_name: 'Mention', foreign_key: 'source_report_id', dependent: :destroy
  has_many :mentioning_reports, through: :given_mentions, source: :target_report

  has_many :received_mentions, class_name: 'Mention', foreign_key: 'target_report_id', dependent: :destroy
  has_many :mentioned_reports, through: :received_mentions, source: :source_report

  validates :title, presence: true
  validates :content, presence: true

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  def detect_report_url_from_content
    content.scan(%r{/reports/(\d+)}).flatten.map(&:to_i)
  end

  # source_report_id（言及元のid）がこの@reportのidと等しいレコードを、mentionsテーブルから削除
  def delete_existing_mentions
    given_mentions.destroy_all
  end

  def register_new_mentions_with_mentions_table(mentioned_report_ids)
    mentioned_report_ids.uniq.each do |target_id| # 配列内に言及先の日報のidが2つ以上存在する場合、uniqメソッドで1つにする
      next if target_id == self.id  # 自己言及は不自然なのでスキップ（日報内で自分を言及するのは不自然）
      Mention.create(source_report_id: self.id, target_report_id: target_id)
    end
  end

  def detect_report_url_and_update_mentions_table
    mentioned_report_ids = detect_report_url_from_content
    delete_existing_mentions
    register_new_mentions_with_mentions_table(mentioned_report_ids)
  end
end
