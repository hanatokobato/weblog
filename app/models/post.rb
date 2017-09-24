class Post < ApplicationRecord
  attr_accessor :new_tag_names

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags, source: :tag
  belongs_to :user

  validates :title, presence: true,
    length: {maximum: Settings.post.title.maxlength}
  validates :body, presence: true,
    length: {maximum: Settings.post.body.maxlength}
  validates :user, presence: true
  validate :picture_size

  after_save :create_tags
  before_update :delete_post_tags

  mount_uploader :picture, PictureUploader
  scope :feed, (lambda do |user_id|
    following_ids = "SELECT followed_id FROM relationships
      WHERE follower_id = :user_id"
    where("user_id IN (#{following_ids})
      OR user_id = :user_id", user_id: user_id)
  end)
  scope :search, (lambda do |search|
    post_ids = "(SELECT post_tags.post_id FROM post_tags INNER JOIN tags
      ON post_tags.tag_id = tags.id
      WHERE tags.name LIKE :search)"
    where("title LIKE :search OR id IN #{post_ids}", search: "%#{search}%")
  end)

  def tag_names
    self.tags.map(&:name).join ", "
  end

  private

  def create_tags
    return unless new_tag_names

    new_tag_names.split(",").each do |name|
      self.tags << Tag.where(name: name).first_or_create!
    end
  end

  def delete_post_tags
    tags.clear
  end

  def picture_size
    if picture.size > Settings.post.picture_size.megabytes
      errors.add :picture, I18n.t("errors.messages.picture_size")
    end
  end
end
