class TimeslotService
  def initialize(user)
    @user = user
  end

  def call
    if @user&.admin?
      Timeslot.all
    elsif @user&.manager?
      @user.timeslots
    elsif @user&.customer?
      customer_timeslot_view
    end
  end

  def customer_timeslot_view
    timeslot = Timeslot.select { |t| t.district == @user.account.district }.reject(&:max_count_inquiry?)
    if timeslot.present?
      timeslot
    else
      Timeslot.all
    end
  end
end
