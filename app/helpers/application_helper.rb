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

  #Auto helpers
  def auto_link(object, opts={})
    if opts.symbolize_keys![:truncate].present?
      link_to truncate(object.to_s, length: opts[:truncate]), object, opts
    else
      link_to object.to_s, object, opts
    end
  end

  def auto_attr_link(attribute, opts={})
    link_to attribute, attribute, opts.symbolize_keys
  end

  def auto_mail(object)
    mail_to object.email, object.email
  end

  def anchor_link(text, anchor, options={})
    content_tag(:a, text, {href: "##{anchor}"}.merge(options))
  end

  # Set class in page
  def active_in_page(path)
    "active" if current_page?(path)
  end

  #Boolean helpers
  def b(value, options = {})
    options = {
      :true => :yes,
      :false => :no,
      :scope => [:boolean],
      :locale => I18n.locale
    }.merge options

    boolean = !!value
    key = boolean.to_s.to_sym

    t(options[key], :scope => options[:scope], :locale => options[:locale])
  end

  def to_boolean(string)
    ActiveRecord::Type::Boolean.new.type_cast_from_database(string)
  end

  def is_boolean?(string)
    ['true', 'false'].include?(string)
  end

  def terms_modal_link
    content_tag(:a, 'Terms & Conditions', data:{toggle:'modal', target:'#terms_of_purchase_modal'})
  end
end
