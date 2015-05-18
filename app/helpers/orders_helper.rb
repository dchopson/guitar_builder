module OrdersHelper
  def editing?
    params[:action] == 'edit'
  end

  def viewing?
    params[:action] == 'show'
  end
end
