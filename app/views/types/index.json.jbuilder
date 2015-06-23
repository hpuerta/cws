json.array!(@types) do |type|
  json.extract! type, :id, :nombre
  json.url type_url(type, format: :json)
end
