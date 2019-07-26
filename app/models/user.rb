class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :account
  has_many :timeslots
  has_many :requests

  EMAIL_LENGTH = (6..50).freeze
  ROLES = %w[customer manager admin].freeze
  enum role: ROLES

  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.a[a-z]+)*\.[a-z]+\z/i }, uniqueness: true
  validates_length_of :email, in: EMAIL_LENGTH
  validates :role, presence: true, inclusion: { in: ROLES }
end
