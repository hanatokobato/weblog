class Statistic
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :from
  attr_accessor :to

  validates :from, presence: true
  validates :to, presence: true

  def posts
    Post.where "created_at BETWEEN ? AND ?", from, to
  end

  def new_users
    User.where "created_at BETWEEN ? AND ?", from, to
  end

  def active_users
    User.joins(:posts).group("users.id")
      .where("posts.created_at BETWEEN ? AND ?", from, to)
      .select("users.id", "users.name", "users.email", "count(posts.id) AS post_count")
      .order("post_count desc").limit Settings.statistic.limit
  end

  def common_posts
    Post.joins("join comments ON posts.id = comments.commentable_id
      AND comments.commentable_type = 'Post'").group("posts.id")
      .where("comments.created_at BETWEEN ? AND ?", from, to)
      .select("posts.*", "count(comments.id) AS comment_count")
      .order("comment_count desc").limit Settings.statistic.limit
  end
end
