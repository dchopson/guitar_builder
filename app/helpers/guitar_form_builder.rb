#TODO need to test this class
class GuitarFormBuilder < ActionView::Helpers::FormBuilder

  def guitar_select(label)
    tags = ''
    Guitar.send(label.to_s.pluralize).each do |a|
      tags += @template.content_tag(:option, a[:text], value: a[:value], data: a[:data])
    end
    tag_with_label(label) do
      @template.select(@object_name, label, nil, {}, options) { tags.html_safe }
    end
  end

  def user_select(label, order_user)
    tags = ''
    User.all.each do |u|
      tags += @template.content_tag(:option, u.name, value: u.id, selected: u == order_user)
    end
    tag_with_label(label) do
      @template.select(@object_name, label, nil, {}, options) { tags.html_safe }
    end
  end

  def guitar_checkbox(label)
    tag_with_label("#{label.to_s}?") do
      @template.check_box(@object_name, label)
    end
  end

  def order_select(label)
    tag_with_label(label) do
      @template.select(@object_name, label, Order.send(label.to_s.pluralize), {}, options)
    end
  end

  def order_text_field(label, readonly=false)
    tag_with_label(label) do
      opts = readonly ? options.merge(readonly: 'readonly') : options
      @template.text_field(@object_name, label, opts)
    end
  end

  private

  def tag_with_label(label)
    @template.content_tag(:div, class: 'form-group') do
      result = "#{@template.label(@object_name, label)}<br>"
      result += yield
      result.html_safe
    end
  end

  def options
    {class: 'form-control'}
  end
end
