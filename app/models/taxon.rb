class Taxon < ActiveRecord::Base

  validates_presence_of :name
  default_scope {order("position asc")}

  has_many :sub_menus, class_name: 'Taxon', foreign_key: 'parent', dependent: :destroy
  belongs_to :root, class_name: 'Taxon'
  before_create :set_position

  scope :roots, ->{ where(parent: nil)}

  def set_position
    self.position = Taxon.first ? Taxon.order('position desc').first.position : 0
  end

end
