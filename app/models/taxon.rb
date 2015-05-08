class Taxon < ActiveRecord::Base

  validates_presence_of :name
  default_scope {order("position asc")}

  has_many :sub_menus, class_name: 'Taxon', foreign_key: 'parent', dependent: :destroy
  has_many :events, foreign_key: 'category_id'
  belongs_to :root, class_name: 'Taxon', foreign_key: 'parent'
  before_create :set_position

  scope :roots, ->{ where(parent: nil)}

  def set_position
    self.position = Taxon.first ? Taxon.order('position desc').first.position : 0
  end
  
  class << self
    
    def select_options
      	all.includes(:root).map{|e| [((e.root.nil? ? '' :  (e.root.try(:name)) + '--' ) + e.name), e.id ]}.sort
    end
  end

end
