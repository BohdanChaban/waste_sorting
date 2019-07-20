class Timeslot < ApplicationRecord
  belongs_to :district
  belongs_to :user, -> { User.manager }, inverse_of: false, optional: false
  validates :start_time, presence: true
end
