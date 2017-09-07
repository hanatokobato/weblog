class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find_by id: params[:followed_id]

    if @user && current_user.follow(@user)
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

    if @user && current_user.unfollow(@user)
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
end
