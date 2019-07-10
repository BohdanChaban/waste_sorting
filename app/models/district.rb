class District < ApplicationRecord
  MAX_NAME_LENGTH = 30
  MIN_NAME_LENGTH = 3

  before_validation :capitalize_name

  belongs_to :city

  validates :name, presence: true
  validates :name, length: { minimum: MIN_NAME_LENGTH, maximum: MAX_NAME_LENGTH }
  validates :name, format: { with: /\A[\'\ а-щА-ЩЬьЮюЯяЇїІіЄєҐґ-]+\z/ }
  validates :name, uniqueness: true

  private

  def capitalize_name
    self.name = name.capitalize
  end
end
