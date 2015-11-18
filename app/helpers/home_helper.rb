module HomeHelper
  def home_tab_button(model, text)
    link_to nil, data:{toggle: 'remoteTab', href: home_load_tab_path(model: model), target: "#pop-#{model.to_s.pluralize}"}, id:"tab-#{model.to_s.pluralize}" do
      content_tag(:span, text)
    end
  end
end
