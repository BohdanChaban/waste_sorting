class Contact < ApplicationRecord
  MAX_TEXT_LENGTH = 60
  validates :name,
            :address,
            :email,
            :mobile_number,
            :facebook,
            :instagram,
            :other_info, length: { maximum: MAX_TEXT_LENGTH }
end
