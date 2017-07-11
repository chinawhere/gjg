class Gensee < ActiveRecord::Base
	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			where("created_at > ?" , Time.now - 60.days).each do |en|
				csv << en.attributes.values_at(*column_names)
			end
		end
	end
end
