class Post < ApplicationRecord
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags, source: :tag
  belongs_to :user

  validates :title, presence: true,
    length: {maximum: Settings.post.title.maxlength}
  validates :body, presence: true,
    length: {maximum: Settings.post.body.maxlength}
  validates :user, presence: true
end
