class Post < ApplicationRecord
  validates :title, :content, presence: true
  has_many :opinions
  has_rich_text :content
  belongs_to :user
  delegate :username, to: :user
end
