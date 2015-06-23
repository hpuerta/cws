class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
    	t.string :solicitante
		t.text :descripcion
		t.string :importancia
		t.string :mail
		t.string :partemaquina
		t.text :descripcionNoRealizado
		t.date :fechaEstimada
		t.text :descripcionEjecucion
		t.datetime :fechaHoraInicio
		t.datetime :fechaHoraFin
		t.string :ejecutor
		t.text :descripcionPendiente
		t.string :estado
      t.timestamps
    end
  end
end
