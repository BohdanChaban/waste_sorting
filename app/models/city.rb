class City < ApplicationRecord
  MAX_NAME_LENGTH = 30
  MIN_NAME_LENGTH = 3
  
  validates :name, presence: true
  validates :name, length: { minimum: MIN_NAME_LENGTH, maximum: MAX_NAME_LENGTH }
  validates :name, format: { with: /\A[\'\ а-щА-ЩЬьЮюЯяЇїІіЄєҐґ-]+\z/ }
  validates :name, uniqueness: true
end
