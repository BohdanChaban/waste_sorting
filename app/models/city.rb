class City < ApplicationRecord
	MAX_NAME_LENGTH = 50
	has_many :districts
	has_many :users

	validates :name, presence: true
end
