#TODO need to test this class
class GuitarFormBuilder < ActionView::Helpers::FormBuilder

  def guitar_select(label)
    tags = ''
    Guitar.send(label.to_s.pluralize).each do |a|
      tags += @template.content_tag(:option, a[:value], value: a[:value], data: a[:data])
    end
    helper = @template.select(@object_name, label) do
      tags.html_safe
    end
    guitar_tag(label, helper)
  end

  def guitar_checkbox(label)
    helper = @template.check_box(@object_name, label)
    guitar_tag(label, helper)
  end

  private

  def guitar_tag(label, helper)
    @template.content_tag(:div, class: 'field') do
      result = "#{@template.label(@object_name, label)}<br>"
      result += helper
      result.html_safe
    end
  end
end
