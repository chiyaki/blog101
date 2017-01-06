class Post < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :article, presence: true
  scope :recent, -> {order("created_at DESC")}
end
