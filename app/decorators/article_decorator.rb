class ArticleDecorator < Draper::Decorator
  delegate_all

  def title
    h.h2_link_to(object.title, object)
  end

  def content
    h.render 'content.html.slim', object: object
  end

  def content_truncated
    object.content = h.truncate object.content, length: 400
    h.render 'content.html.slim', object: object
  end

  def created_at
    h.created_at(object.created_at)
  end
end
