class StaticPagesController < ApplicationController
  def show
    if valid_page?
      if params[:page_type] == "home"
        if user_signed_in?
          @post = current_user.posts.build
          @feed_items = Post.feed(current_user.id).order(created_at: :desc)
            .paginate page: params[:page], per_page: Settings.post.per_page
        else
          @posts = Post.all.order(created_at: :desc)
            .paginate page: params[:page], per_page: Settings.post.per_page
        end
      end

      render "#{params[:page_type]}"
    else
      render file: "public/404.html", status: :not_found
    end
  end

  private

  def valid_page?
    File.exist? Pathname.new Rails.root +
      "app/views/static_pages/#{params[:page_type]}.html.erb"
  end
end
