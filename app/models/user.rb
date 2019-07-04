class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  LENGTHEMAIL = (6..50).to_a.freeze
  ROLE = %i[customer manager admin].freeze
  enum role: [ROLE]

  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.a[a-z]+)*\.[a-z]+\z/i }, uniqueness: true
  validates_length_of :email, in: LENGTHEMAIL
  validates :role, presence: true
  validates :role, inclusion: { in: ROLE }
end
