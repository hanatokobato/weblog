class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find_by id: params[:followed_id]
    verify_user

    if current_user.follow @user
      respond_to do |format|
        format.html{redirect_to @user}
        format.js
      end
    else
      respond_to do |format|
        format.html do
          flash[:danger] = t ".can_not_follow"
          redirect_to request.referrer || root_url
        end
        format.js{@error = t ".can_not_follow"}
      end
    end
  end

  def destroy
    @user = Relationship.find_by(id: params[:id]).followed
    verify_user

    if current_user.unfollow @user
      respond_to do |format|
        format.html{redirect_to @user}
        format.js
      end
    else
      respond_to do |format|
        format.html do
          flash[:danger] = t ".can_not_unfollow"
          redirect_to request.referrer || root_url
        end
        format.js{@error = t ".can_not_unfollow"}
      end
    end
  end

  private

  def verify_user
    return if @user
    flash[:danger] = t ".not_found"
    redirect_to root_url
  end
end
