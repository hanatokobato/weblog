class StatisticsController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin!
  before_action :load_statistic, only: :statistic

  def index; end

  def statistic
    if @statistic.valid?
      @statistic_type = params[:statistic_type]
      @title = t(".#{@statistic_type}") + "#{@statistic.from} -> #{@statistic.to}" +
        " (#{@statistic.send(@statistic_type).length})"
      respond_to do |format|
        format.html {
          @objects = @statistic.send("#{@statistic_type}").page(params[:page])
            .per Settings.post.per_page
          render :index
        }
        format.xls {
          @objects = @statistic.send("#{@statistic_type}")
          filename = "#{@title}.xls"
          send_data(@objects.to_a.to_xls,
            type: "text/xls; charset=utf-8; header=present",
            filename: filename)
        }
      end
    else
      respond_to do |format|
        format.html {
          flash.now[:warning] = t ".invalid_date"
          render :index
        }
      end
    end
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
