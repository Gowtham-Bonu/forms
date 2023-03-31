class Employee < ApplicationRecord
  has_many :addresses, inverse_of: :employee, dependent: :destroy
  accepts_nested_attributes_for :addresses

  validates :employee_name, :email, :password, :birth_date, :gender, :mobile_number, presence: :true
  validates :email, :password, :mobile_number, uniqueness: true
  validates :password, length: { is: 6 }
  validates :birth_date, comparison: { less_than: Date.today }
  validates :mobile_number, length: { is: 10 }
  mount_uploader :document, ImageUploader
end
