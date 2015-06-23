class Tag < ActiveRecord::Base
	belongs_to :request
	belongs_to :type
end
