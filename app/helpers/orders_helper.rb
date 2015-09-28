module OrdersHelper

  # @return [Boolean] is this the new action?
  def creating?
    params[:action] == 'new'
  end

  # @return [Boolean] is this the edit action?
  def editing?
    params[:action] == 'edit'
  end

  # @return [Boolean] is this the show action?
  def viewing?
    params[:action] == 'show'
  end
end
