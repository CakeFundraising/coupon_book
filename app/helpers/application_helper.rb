module ApplicationHelper
  def wizard_menu_item(path, text, options={})
    if current_page?(path)
      content_tag(:li, class:'active') do
        content_tag(:a, text, data: {toggle: 'tab'})
      end
    else
      content_tag :li do
        link_to text, path, options
      end
    end
  end
end
