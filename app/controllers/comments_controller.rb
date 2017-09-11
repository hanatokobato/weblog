class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i(create edit update destroy)
  before_action :load_commentable
  before_action :load_comment, only: %i(edit update destroy)
  before_action :verify_create, only: :create
  before_action :verify_update, only: :update
  before_action :verify_destroy, only: :destroy

  def index
    @comments = @commentable.comments

    respond_to do |format|
      format.html {redirect_to request.referrer || root_url}
      format.js
    end
  end

  def create
    @comment = @commentable.comments.build comment_params
    @comment.user_id = current_user.id

    if @comment.save
      respond_to do |format|
        format.html do
          flash[:success] = t ".comment_created"
          redirect_to request.referrer || root_url
        end
        format.js
      end
    else
      respond_to do |format|
        format.html do
          flash[:danger] = t ".can_not_create"
          redirect_to request.referrer || root_url
        end
        format.js
      end
    end
  end

  def edit
  end

  def update
    if @comment.update_attributes comment_params
      respond_to do |format|
        format.html do
          flash[:success] = t ".comment_updated"
          redirect_to request.referrer || root_url
        end
        format.js
      end
    else
      respond_to do |format|
        format.html do
          flash[:danger] = t ".can_not_update"
          redirect_to request.referrer || root_url
        end
        format.js
      end
    end
  end

  def destroy
    if @comment.destroy
      respond_to do |format|
        format.html do
          flash[:success] = t ".comment_deleted"
          redirect_to request.referrer || root_url
        end
        format.js
      end
    else
      respond_to do |format|
        format.html do
          flash[:danger] = t ".can_not_delete"
          redirect_to request.referrer || root_url
        end
        format.js
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit :content
  end

  def load_commentable
    @post = Post.find_by id: params[:post_id]

    unless @post
      flash[:danger] = t ".can_not_find_post"
      redirect_to request.referrer || root_url
    end

    if params[:comment_id]
      @commentable = Comment.find_by id: params[:comment_id]
      return
    end
    @commentable = @post
  end

  def load_comment
    @comment = @commentable.comments.find_by id: params[:id]

    return if @comment
    flash[:danger] = t ".comment_not_found"
    redirect_to request.referrer || root_url
  end

  def verify_create
    unless current_user.is_user?(@post.user) || current_user.following?(@post.user)
      flash[:danger] = t ".can_not_comment"
      redirect_to request.referrer || root_url
    end
  end

  def verify_update
    return if current_user.is_user? @comment.user
    flash[:danger] = t ".can_not_edit"
    redirect_to request.referrer || root_url
  end

  def verify_destroy
    return if current_user.is_user?(@comment.user) || current_user.is_user?(@post.user)
    flash[:danger] = t ".can_not_delete"
    redirect_to request.referrer || root_url
  end
end
