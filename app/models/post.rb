class Post < ApplicationRecord
  validates :title, :content, presence: true
  has_many :opinions
  belongs_to :user
  delegate :username, to: :user
end
