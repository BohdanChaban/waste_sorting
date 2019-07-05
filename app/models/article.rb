class Article < ApplicationRecord
  MAX_TITLE_LENGTH = (5..40).freeze
  validates_length_of :title, in: MAX_TITLE_LENGTH, too_long: 'pick a shorter name', too_short: 'pick a longer name'
  validates :summary, presence: true
  validates :body, presence: true
end
