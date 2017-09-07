class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i(index show)
  before_action :load_user, only: %i(show following followers)

  def index
    @users = User.select(:id, :name, :email).order(:name)
      .page(params[:page]).per Settings.users.per_page
  end

  def show
    @posts = @user.posts.order_latest
      .page(params[:page]).per Settings.post.per_page
  end

  def following
    @title = t ".following"
    @users = @user.following.page(params[:page]).per Settings.users.per_page
    render "show_follow"
  end

  def followers
    @title = t ".followers"
    @users = @user.followers.page(params[:page]).per Settings.users.per_page
    render "show_follow"
  end

  private

  def load_user
    @user = User.find_by id: params[:id]

    return if @user
    flash[:danger] = t ".not_found"
    redirect_to root_url
  end
end
