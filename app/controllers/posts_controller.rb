class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i(create update destroy)
  before_action :correct_user, only: :destroy

  def index
    if params[:search]
      @posts = Post.search(params[:search]).page(params[:page])
        .per Settings.post.per_page
    elsif params[:tag_name]
      tag = Tag.find_by name: params[:tag_name]

      unless tag
        flash[:danger] = t ".not_found"
        redirect_to root_url
      else
        @posts = tag.posts.page(params[:page]).per Settings.post.per_page
      end
    end
  end

  def show
    @post = Post.find_by id: params[:id]
  end

  def create
    @post = current_user.posts.build post_params

    if @post.save
      flash[:success] = t ".created"
      redirect_to root_url
    else
      @feed_items = [];
      flash[:danger] = t ".invalid_tags"
      render "static_pages/home"
    end
  end

  def update
    @post = Post.find_by id: params[:id]

    if @post.update_attributes post_params
      flash[:success] = t ".updated"
      redirect_to request.referrer || root_url
    else
      flash.now[:danger] = t ".failed"
      render :show
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = t ".deleted"
    else
      flash[:danger] = t ".failed"
    end

    redirect_to request.referrer || root_url
  end

  private

  def post_params
    params.require(:post).permit :title, :body, :picture, :new_tag_names
  end

  def correct_user
    @post = current_user.posts.find_by id: params[:id]
    redirect_to root_url if @post.nil?
  end
end
