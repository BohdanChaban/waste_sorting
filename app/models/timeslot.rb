class Timeslot < ApplicationRecord
  belongs_to :district
  has_many :inquiries
  belongs_to :user, -> { User.manager }, inverse_of: false, optional: false
  validates :start_time, presence: true

  MAX_COUNT_INQUIRY = 3

  def max_count_inquiry?
    inquiries.count >= MAX_COUNT_INQUIRY
  end
end
