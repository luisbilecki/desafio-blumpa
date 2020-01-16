module Json
  def convert_to_json(data)
    ActiveSupport::JSON.decode(data)
  end
end