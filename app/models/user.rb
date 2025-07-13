# frozen_string_literal: true

class User < ApplicationRecord
  has_many :reports, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [150, 150]
  end

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  def display_name
    name.present? ? name : email
  end
end
