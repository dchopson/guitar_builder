#TODO need to test this class
class GuitarFormBuilder < ActionView::Helpers::FormBuilder

  def guitar_select(label)
    tags = ''
    Guitar.send(label.to_s.pluralize).each do |a|
      tags += @template.content_tag(:option, a[:value], value: a[:value], data: a[:data])
    end
    guitar_tag(label) do
      @template.select(@object_name, label) { tags.html_safe }
    end
  end

  def guitar_checkbox(label)
    guitar_tag(label) do
      @template.check_box(@object_name, label)
    end
  end

  private

  def guitar_tag(label)
    @template.content_tag(:div, class: 'field') do
      result = "#{@template.label(@object_name, label)}<br>"
      result += yield
      result.html_safe
    end
  end
end
