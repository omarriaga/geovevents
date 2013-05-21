class Ticket < ActiveRecord::Base

  attr_accessible :id_vigia, :id_reporte, :lon, :lat, :observacion, :fecha_ticket, :id_activo

end
