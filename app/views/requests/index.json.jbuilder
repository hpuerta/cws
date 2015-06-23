json.array!(@requests) do |request|
  json.extract! request, :id, :solicitante, :descripcion, :importancia, :mail, :partemaquina, :descripcionNoRealizado, :fechaEstimada, :descripcionEjecucion, :fechaHoraInicio, :fechaHoraFin, :ejecutor, :descripcionPendiente, :estado
  json.url request_url(request, format: :json)
end
