class Article < ApplicationRecord
  TITLE_LENGTH_RANGE = (5..40).freeze

  before_validation :capitalize_options

  validates_length_of :title, in: TITLE_LENGTH_RANGE
  validates :title, presence: true
  validates :summary, presence: true
  validates :body, presence: true

  def capitalize_options
    self.title = title.capitalize
  end
end
