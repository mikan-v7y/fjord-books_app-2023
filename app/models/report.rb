class Report < ApplicationRecord
  has_many :comments, as: :commentable
end
