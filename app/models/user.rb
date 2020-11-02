class User < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  validates :email, uniqueness: true, presence: true
  enum role: %w(default employee admin)
  belongs_to :merchant, optional: true

  has_many :orders

  has_secure_password
end
