class Inquiry < ApplicationRecord
  belongs_to :user, -> { User.customer }, inverse_of: false, optional: false
  belongs_to :timeslot

  STATUS = %w[initiated approved declined cancelled completed].freeze
  enum status: STATUS

  validates :status, presence: true, inclusion: { in: STATUS }
  validate :free_timeslot

  def free_timeslot
    errors.add(:timeslot, 'For this timeslot, all inquiries are busy') if timeslot.max_count_inquiry?
  end
end
