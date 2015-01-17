json.array!(@orders) do |order|
  json.extract! order, :id, :number, :completion_date, :status, :delivery_type, :first_name, :last_name, :address, :telephone, :email, :cc_number, :user_id, :lock_version
  json.url order_url(order, format: :json)
end
