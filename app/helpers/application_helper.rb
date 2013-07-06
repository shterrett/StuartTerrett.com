module ApplicationHelper
  
  def render_flash
    html = flash.map do |key, msg|
      content_tag :div, msg, :id => key, :class => 'flash'
    end.join
    raw(html)
  end
  
  def render_markdown(text)
    raw(Md.parser.render(text)) unless text.blank?
  end
  
end
