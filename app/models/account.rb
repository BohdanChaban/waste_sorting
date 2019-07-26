class Account < ApplicationRecord
  belongs_to :user,  optional: false
  belongs_to :city,  optional: false
  MAX_NAME_LENGTH = 25
  MAX_SURNAME_LENGTH = 25
  MIN_MOBILE_NUMBER = 10
  MAX_MOBILE_NUMBER = 15
  MAX_ADDRESS_LENGTH = 30

  before_validation :capitalize_options

  validates :name, :surname, :address, :mobile_number, presence: true
  validates :name, length: { maximum: MAX_NAME_LENGTH }
  validates :surname, length: { maximum: MAX_SURNAME_LENGTH }
  validates :address, length: { maximum: MAX_ADDRESS_LENGTH }
  validates :mobile_number, length: { minimum: MIN_MOBILE_NUMBER, maximum: MAX_MOBILE_NUMBER }
  validates :mobile_number, format: { with: /\d[0-9]\)*\z/ }
  validates_uniqueness_of :user_id

  def capitalize_options
    self.name = name.capitalize
    self.surname = surname.capitalize
  end
end
