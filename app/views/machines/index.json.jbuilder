json.array!(@machines) do |machine|
  json.extract! machine, :id, :nombre
  json.url machine_url(machine, format: :json)
end
