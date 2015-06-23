class Request < ActiveRecord::Base
	belongs_to :category
	belongs_to :machine
	has_many :tags
	has_many :types, through: :tags

	scope :noLeidos, -> { where(estado: '_noLeido') }
	scope :Leidos, -> { where(estado: 'Leido') }
	scope :Pendientes, -> { where(estado: 'Pendiente') }
	scope :Solucionados, -> { where(estado: 'Solucionado') }
	scope :Alta, -> { where(importancia: 'Alta') }
	scope :Media, -> { where(importancia: 'Media') }
	scope :Baja, -> { where(importancia: 'Baja') }
end
