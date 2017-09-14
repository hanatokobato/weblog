class StatisticsController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin!
  before_action :load_statistic, only: %i(active_users common_posts users posts)

  def index
  end

  def statistic
    if params[:commit] == "Posts"
      redirect_to statistic_posts_url statistic: statistic_params
    elsif params[:commit] == "New Users"
      redirect_to statistic_users_url statistic: statistic_params
    elsif params[:commit] == "Active Users"
      redirect_to statistic_active_users_url statistic: statistic_params
    elsif params[:commit] == "Common Posts"
      redirect_to statistic_common_posts_url statistic: statistic_params
    end
  end

  def active_users
    if @statistic.valid?
      @title = t(".active_users") + "#{@statistic.from} -> #{@statistic.to} "
      @objects = @statistic.active_users.paginate page: params[:page]
    else
      flash.now[:warning] = t ".invalid_date"
    end
    render :index
  end

  def common_posts
    if @statistic.valid?
      @title = t(".common_posts") + "#{@statistic.from} -> #{@statistic.to} "
      @objects = @statistic.common_posts.paginate page: params[:page]
    else
      flash.now[:warning] = t ".invalid_date"
    end
    render :index
  end

  def users
    if @statistic.valid?
      @title = t(".users") + "#{@statistic.from} -> #{@statistic.to} " +
        "(#{@statistic.users.size})"
      @objects = @statistic.users.paginate page: params[:page],
        per_page: Settings.users.per_page
    else
      flash.now[:warning] = t ".invalid_date"
    end
    render :index
  end

  def posts
    if @statistic.valid?
      @title = t(".posts") + "#{@statistic.from} -> #{@statistic.to} " +
        "(#{@statistic.posts.size})"
      @objects = @statistic.posts.paginate page: params[:page],
        per_page: Settings.post.per_page
    else
      flash.now[:warning] = t ".invalid_date"
    end
    render :index
  end

  private

  def statistic_params
    params.require(:statistic).permit :from, :to
  end

  def load_statistic
    @statistic = Statistic.new statistic_params
  end

  def verify_admin!
    return if current_user.admin?
    flash[:danger] = t ".can_not_view"
    redirect_to request.referrer || root_url
  end
end
