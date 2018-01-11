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
      result << load_span_tag(m, n)
    end
    safe_join result
  end

  def load_span_tag m, n
    if n <= m
      content_tag :span, nil, class: "fa fa-star checked w-space"
    else
      content_tag :span, nil, class: "fa fa-star w-space"
    end
  end
end
