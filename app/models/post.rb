class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_rich_text :content
  has_many_attached :photos

  validates :title, :content, :url, presence: true
  validates :title, length: { maximum: 40,
                              too_long: "%{count} characters is the maximum allowed" }
end
