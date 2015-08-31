#TODO need to test this class
class GuitarFormBuilder < ActionView::Helpers::FormBuilder

  def guitar_select(label, temp=false)
    choices = @template.options_for_select(Guitar.send(label.to_s.pluralize), @object.send(label))
    css_class = temp ? [:preview, :temp] : :preview

    @template.content_tag(:div, class: 'col-md-3') do
      @template.content_tag(:div, class: 'thumbnail') do
        result = ''
        result += @template.image_tag('placeholder.png', id: label, class: css_class)
        result += @template.content_tag(:div, class: 'caption') do
          tag_with_label(label) do
            @template.select(@object_name, label, choices, {}, options)
          end
        end
        result.html_safe
      end
    end
  end

  def user_select
    tag_with_label(:user_id) do
      @template.select(@object_name, :user_id, User.all_for_select, {}, options)
    end
  end

  def guitar_checkbox(label)
    tag_with_label("#{label.to_s}?") do
      @template.check_box_tag("#{@object_name}[#{label}]", 1, @object.send(label))
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
