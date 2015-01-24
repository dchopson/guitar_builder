module OrdersHelper
  def editing?
    params[:action] == 'edit'
  end
end
