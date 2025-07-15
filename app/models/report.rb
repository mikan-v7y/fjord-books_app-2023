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
end
