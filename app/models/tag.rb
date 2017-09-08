class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :post_tags, source: :post

  validates :name, presence: true,
    length: {maximum: Settings.tag.name.maxlength}, uniqueness: true
end
