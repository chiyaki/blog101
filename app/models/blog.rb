class Blog < ApplicationRecord
  validates :title, presence: true
  belongs_to :user
  has_many :posts, :dependent => :destroy
end
