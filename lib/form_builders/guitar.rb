module FormBuilders
  class Guitar < ActionView::Helpers::FormBuilder
    include Shared

    def select(label)
      choices = @template.options_for_select(::Guitar.public_send(label.to_s.pluralize), @object.public_send(label))

      @template.content_tag(:div, class: 'col-md-3') do
        @template.content_tag(:div, class: 'thumbnail') do
          result = ''
          result += @template.image_tag('placeholder.png', id: label, class: :preview)
          result += @template.content_tag(:div, class: 'caption') do
            tag_with_label(label) do
              @template.select(@object_name, label, choices, {}, options)
            end
          end
          result.html_safe
        end
      end
    end

    def checkbox(label)
      tag_with_label("#{label.to_s}?") do
        @template.check_box_tag("#{@object_name}[#{label}]", 1, @object.public_send(label))
      end
    end
  end
end
