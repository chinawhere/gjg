class Player < ActiveRecord::Base
  has_one :enlist
  def self.construct_from_sso detail
    create(
      :username  => detail['username'] || detail['fullname'],
      :email     => detail['email'],
      :mobile    => detail['mobile'],
      :global_id => detail['globalId']
    )
  end
	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |en|
				csv << en.attributes.values_at(*column_names)
			end
		end
	end
end
