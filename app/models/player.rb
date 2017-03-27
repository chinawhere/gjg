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
end
