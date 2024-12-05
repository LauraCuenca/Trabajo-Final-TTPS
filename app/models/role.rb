class Role < ApplicationRecord
  has_and_belongs_to_many :users, join_table: :users_roles
  before_save :downcase_name

  belongs_to :resource,
             polymorphic: true,
             optional: true


  validates :resource_type,
            inclusion: { in: Rolify.resource_types },
            allow_nil: true

  scopify



  private
  def downcase_name
    self.name = name.downcase if name.present?
  end
end
