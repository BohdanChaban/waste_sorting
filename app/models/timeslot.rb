class Timeslot < ApplicationRecord
  belongs_to :district
  has_many :inquiries
  belongs_to :user, -> { User.manager }, inverse_of: false, optional: false
  validates :start_time, presence: true
end
