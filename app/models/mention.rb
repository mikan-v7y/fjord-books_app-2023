# frozen_string_literal: true

class Mention < ApplicationRecord
  belongs_to :source_report, class_name: 'Report'
  belongs_to :target_report, class_name: 'Report'
end
