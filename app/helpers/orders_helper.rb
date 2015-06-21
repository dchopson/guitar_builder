module OrdersHelper
  def creating?
    params[:action] == 'new'
  end

  def editing?
    params[:action] == 'edit'
  end

  def viewing?
    params[:action] == 'show'
  end
end
