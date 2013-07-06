module ApplicationHelper
  
  def render_flash
    html = flash.map do |key, msg|
      content_tag :div, msg, :id => key, :class => 'flash'
    end.join
    html.html_safe
  end
  
  def render_markdown(text)
    Md.parser.render(text).html_safe unless text.blank?
  end
  
end
