# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ACCEPTED_CONTENT_TYPES = ['image/jpeg', 'image/png', 'image/gif'].freeze

  has_one_attached :avatar

  validates :avatar, attached: true, content_type: ACCEPTED_CONTENT_TYPES
end
