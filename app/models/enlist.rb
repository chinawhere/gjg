class Enlist < ActiveRecord::Base
	belongs_to :player
	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |en|
				csv << en.attributes.values_at(*column_names)
			end
		end
	end
end
