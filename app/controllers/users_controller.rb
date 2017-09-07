class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i(index show)
  before_action :load_user, only: :show

  def index
    @users = User.select(:id, :name, :email).order(:name)
      .page(params[:page]).per Settings.users.per_page
  end

  def show; end

  private

  def load_user
    @user = User.find_by id: params[:id]

    return if @user
    flash[:danger] = t ".not_found"
    redirect_to root_url
  end
end
