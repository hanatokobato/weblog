module PostsHelper
  def tag_links tag_names
    tag_names.split(",").map{|tag| link_to tag.strip, tag_path(tag.strip),
      class: "label label-info"}
      .join ", "
  end
end
