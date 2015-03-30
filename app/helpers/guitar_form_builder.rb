#TODO need to test this class
class GuitarFormBuilder < ActionView::Helpers::FormBuilder

  def guitar_select(label)
    tags = ''
    Guitar.send(label.to_s.pluralize).each do |a|
      tags += @template.content_tag(:option, a[:value], value: a[:value], data: a[:data])
    end
    tag_with_label(label) do
      @template.select(@object_name, label, nil, {}, {class: 'form-control'}) { tags.html_safe }
    end
  end

  def guitar_checkbox(label)
    tag_with_label("#{label.to_s}?") do
      @template.check_box(@object_name, label)
    end
  end

  def order_select(label)
    tag_with_label(label) do
      @template.select(@object_name, label, Order.send(label.to_s.pluralize), {}, {class: 'form-control'})
    end
  end

  def order_text_field(label)
    tag_with_label(label) do
      @template.text_field(@object_name, label, class: 'form-control')
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
end
