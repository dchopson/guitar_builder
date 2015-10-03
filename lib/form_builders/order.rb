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

    def text_field(label, opts={})
      tag_with_label(label) do
        @template.text_field(@object_name, label, options.merge(opts))
      end
    end

    def text_area(label)
      tag_with_label(label) do
        @template.text_area(@object_name, label, options.merge(rows: 4))
      end
    end
  end
end
