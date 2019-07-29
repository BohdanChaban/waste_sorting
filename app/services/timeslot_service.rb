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
      Timeslot.select{ |m| !m.max_count_inquiry? }.select { |t| t.district == @user.account.district  }
    end
  end
end
