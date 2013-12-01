module ApplicationHelper
  def render_flash
    html = flash.map do |key, msg|
      style = case key
              when :error
                'alert-box alert radius'
              when :success
                'alert-box success radius'
              else
                'alert-box secondary radius'
              end
      content_tag :div, msg, id: key, class: style
    end.join
    html.html_safe
  end

  def render_markdown(text)
    Md.parser.render(text).html_safe unless text.blank?
  end

  def fill_row(item_array, number_cells, class_string)
    if item_array.length < number_cells
      html = ''
      (number_cells - item_array.length % number_cells).times do
        html += "<div class=#{class_string}></div>"
      end
      html.html_safe
    end
  end
end
