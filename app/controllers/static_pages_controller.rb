class StaticPagesController < ApplicationController
  def show
    if valid_page?
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
