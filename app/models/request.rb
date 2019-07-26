class Request < ApplicationRecord
  belongs_to :user
  belongs_to :timeslot

  STATUS = %w[initiated approved declined cancelled completed].freeze
  enum status: STATUS

  validates :status, presence: true, inclusion: { in: STATUS }
end
