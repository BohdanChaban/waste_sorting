class Contact < ApplicationRecord
  MAX_NAME_LENGTH = 60
  MAX_ADDRESS_LENGTH = 120
  MAX_EMAIL_LENGTH = 50
  MAX_MOBILE_NUMBER = 30
  MAX_TEXT_LENGTH = 60

  validates :name, length: { maximum: MAX_NAME_LENGTH }
  validates :address, length: { maximum: MAX_ADDRESS_LENGTH }
  validates :email, length: { maximum: MAX_EMAIL_LENGTH }
  validates :mobile_number, length: { maximum: MAX_MOBILE_NUMBER }

  validates :facebook,
            :instagram,
            :other_info, length: { maximum: MAX_TEXT_LENGTH }
end
