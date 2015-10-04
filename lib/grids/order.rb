module Grids
  class Order
    include Datagrid

    #TODO docs & specs

    scope do
      ::Order.all.includes(:user)
    end

    # filter(:category, :enum, :select => ["first", "second"])
    # filter(:disabled, :xboolean)
    # filter(:group_id, :integer, :multiple => true)
    # filter(:logins_count, :integer, :range => true)
    # filter(:group_name, :string, :header => "Group") do |value|
    #   self.joins(:group).where(:groups => {:name => value})
    # end
    filter(:user, :enum, select: User.all_for_select) do |value|
      self.where(user_id: value)
    end

    column(:number)
    column(:completion_date)
    column(:status)
    column(:name, order: :last_name)
    column(:telephone)
    column(:email)
    column(:user, order: 'users.first_name') do |order|
      order.user.try(:name)
    end
    column(:actions, html: true) do |order|
      content_tag(:td, class: 'td-button') do
        content_tag(:div, class: 'btn-group') do
          link_to 'Edit', edit_order_path(order), role: 'button', class: 'btn btn-default'
          button_tag(type: 'button', class: 'btn btn-default dropdown-toggle', data: {toggle: 'dropdown'}) do
            content_tag(:span, class: 'caret')
          end
          content_tag(:ul, class: 'dropdown-menu', role: 'menu') do
            content_tag(:li) do
              link_to 'Delete', order, method: :delete, data: { confirm: 'Are you sure?' }
            end
          end
        end
      end
    end
  end
end
