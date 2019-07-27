class Inquiry < ApplicationRecord
  belongs_to :user, -> { User.customer }, inverse_of: false, optional: false
  belongs_to :timeslot

  STATUS = %w[initiated approved declined cancelled completed].freeze
  enum status: STATUS

  validates :status, presence: true, inclusion: { in: STATUS }
end
