module ApplicationHelper

  def currented_page(relative_root)
    current_page?(relative_root) ? :selected : nil
  end

  def h2_link_to(title, route)
    content_tag(:h2) do
      link_to title, route
    end
  end

  def created_at(datetime)
    I18n.l datetime, :format => :normal
  end
end
