class User < ApplicationRecord
  before_create :set_default_avatar
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :photo

  validates :nickname, length: { maximum: 50,
                                too_long: "%{count} characters is the maximum allowed" }

  private

  def set_default_avatar
    self.photo.attach(io: File.open(Rails.root.join('app', 'assets', 'images',
                                                    ['rabbit.png', 'dog.png', 'cat.png'].sample)),
                      filename: 'default-avatar.png', content_type: 'image/png')
  end
end
