class City < ApplicationRecord
  MAX_NAME_LENGTH = 30
  validates :name, presence: true, length: { maximum: MAX_NAME_LENGTH }
end
