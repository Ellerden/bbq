class User < ApplicationRecord
  has_many :events

  validates :name, presence: true, length: {maximum: 35}
  validates :email, presence: true, length: {maximum: 45}
  validates :email, uniqueness: true
  validates :email, format: /\A[a-z\d_.\-]+@([a-z\d.\-])+\.[a-z]+\z/i
end
