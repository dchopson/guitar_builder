module FormBuilders
  module Shared
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
end
