class Inquiry < ApplicationRecord
  belongs_to :user, -> { User.customer }, inverse_of: false, optional: false
  belongs_to :timeslot

  STATUS = %w[initiated approved declined cancelled completed].freeze
  enum status: STATUS

  validates :status, presence: true, inclusion: { in: STATUS }
  validate :free_timeslot, on: :create
  validate :free_inquiry

  def free_timeslot
    errors.add(:timeslot, 'For this timeslot, all inquiries are busy') if timeslot.max_count_inquiry?
  end

  def free_inquiry
    errors.add(:timeslot, 'You have already created queries in this timeslot.') if one_inquiry
  end

  def one_inquiry
    Inquiry.find_by(user: user, timeslot_id: timeslot).present?
  end
end
