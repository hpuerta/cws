class Type < ActiveRecord::Base
	has_many :tags
	has_many :requests, through: :tags
end
