class User < ApplicationRecord
  has_many :comments
  has_many :ideas
  has_and_belongs_to_many :goals, class_name: 'Idea'
  has_secure_password

  validates :email, uniqueness: true
  validates :role, inclusion: { in: %w(admin registered) }

  before_validation :downcase_email
  after_initialize :default_role!
  
  private

  def default_role!
    self.role = "registered" if role.nil?
  end
  
  def downcase_email
    self.email = email.downcase
  end
end
