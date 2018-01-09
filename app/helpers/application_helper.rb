module ApplicationHelper
  def render_rating
    result = []
    (1..5).each do |m|
      result << (content_tag :li do
        link_to books_path(star: m) do
          load_star m
        end
      end)
    end
    safe_join result
  end

  def load_star m
    result = []
    (1..5).each do |n|
      if n <= m
        result << (content_tag :span, class: "fa fa-star checked" do
          "&nbsp;".html_safe
        end)
      else
        result << (content_tag :span, class: "fa fa-star" do
           "&nbsp;".html_safe
        end)
      end
    end
     safe_join result
  end
end
