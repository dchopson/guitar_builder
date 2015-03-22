module OrdersHelper
  def editing?
    params[:action] == 'edit'
  end

  def guitar_select(form, label)
    tags = ''
    Guitar.send(label.to_s.pluralize).each do |a|
      tags += content_tag(:option, a.first, value: a.first, data: {price: a.last})
    end
    result = "#{form.label(label)}<br>"
    result += form.select(label) do
      tags.html_safe
    end
    result.html_safe
  end
end
