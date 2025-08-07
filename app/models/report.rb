# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :given_mentions, class_name: 'Mention', foreign_key: 'source_report_id', dependent: :destroy, inverse_of: :source_report
  has_many :mentioning_reports, through: :given_mentions, source: :target_report

  has_many :received_mentions, class_name: 'Mention', foreign_key: 'target_report_id', dependent: :destroy, inverse_of: :target_report
  has_many :mentioned_reports, through: :received_mentions, source: :source_report

  validates :title, presence: true
  validates :content, presence: true

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  def save_with_mentions!
    given_mentions.destroy_all
    create_mentions!(mentioned_report_ids)
  end

  private

  def mentioned_report_ids
    @mentioned_report_ids ||= content.scan(%r{http://(?:localhost|127\.0\.0\.1):3000/reports/(\d+)}).flatten.map(&:to_i)
  end

  def create_mentions!(mentioned_report_ids)
    mentioned_report_ids.uniq.each do |target_id|
      next if target_id == id  # 自己言及は不自然なのでスキップ（日報内で自分を言及するのは不自然）

      Mention.create!(source_report_id: id, target_report_id: target_id)
    end
  end
end
