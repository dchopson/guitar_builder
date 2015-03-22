module OrdersHelper
  def editing?
    params[:action] == 'edit'
  end

  # TODO this isn't working
  # def guitar_select(form, label)
  #   plural_label = label.to_s.pluralize
  #   form.label label
  #   form.select(label) do
  #     Guitar.send(plural_label).each do |a|
  #       content_tag(:option, a.first, value: a.first, data: {price: a.last})
  #     end
  #   end
  # end

  # <%= f.select(:city_id) do %>
  #   <% [['Lisbon', 1], ['Madrid', 2]].each do |c| -%>
  #     <%= content_tag(:option, c.first, value: c.last) %>
  #   <% end %>
  # <% end %>

end
