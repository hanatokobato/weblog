class Post < ApplicationRecord
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags, source: :tag
  belongs_to :user
end
