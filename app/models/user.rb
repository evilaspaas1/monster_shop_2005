class User < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  validates :email, uniqueness: true, presence: true
  enum role: %w(default employee admin)

  has_many :orders

  has_secure_password
end
