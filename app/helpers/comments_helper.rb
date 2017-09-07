module CommentsHelper
  def commentable_type commentable
    commentable.class.name.downcase
  end

  def can_edit_comment? comment
    user_signed_in? && current_user.is_user?(comment.user)
  end

  def can_delete_comment? comment, post
    user_signed_in? &&
      (current_user.is_user?(comment.user) || current_user.is_user?(post.user))
  end

  def can_comment? post
    user_signed_in? &&
      (current_user.is_user?(post.user) || current_user.following?(post.user))
  end
end
