class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i(create destroy)
  before_action :correct_user, only: :destroy

  def create
    @post = current_user.posts.build post_params

    if @post.save
      flash[:success] = t ".created"
      redirect_to root_url
    else
      render "static_pages/home"
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
