class User < ApplicationRecord
  enum role: [ :customer, :manager , :admin ]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
