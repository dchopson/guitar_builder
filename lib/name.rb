module Name
  # @return [String] concatentation of first and last names
  def name
    return '' unless first_name && last_name
    "#{last_name}, #{first_name}"
  end
end
