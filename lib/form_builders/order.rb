module FormBuilders
  class Order < ActionView::Helpers::FormBuilder
    include Shared

    def select(label)
      tag_with_label(label) do
        @template.select(@object_name, label, ::Order.public_send(label.to_s.pluralize), {}, options)
      end
    end

    def user_select
      tag_with_label(:user_id) do
        @template.select(@object_name, :user_id, User.all_for_select, {}, options)
      end
    end

    def text_field(label, readonly=false)
      tag_with_label(label) do
        opts = readonly ? options.merge(readonly: 'readonly') : options
        @template.text_field(@object_name, label, opts)
      end
    end
  end
end
