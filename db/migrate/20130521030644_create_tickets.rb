class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string  :id_vigia
	  t.integer :id_reporte
	  t.float :lon
	  t.float :lat
	  t.text :observacion
	  t.string :pionero
	  t.date :fecha_ticket 
	  t.integer :id_activo
      t.timestamps
    end
  end
end
