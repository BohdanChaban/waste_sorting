class TimeslotService
  def initialize(user)
    @user = user
  end

  def timeslot_check_role
    if @user&.manager?
      @user.timeslots
    elsif @user&.customer?
      Timeslot.select { |t| t.district.city == @user.account.city }
    elsif @user&.admin?
      Timeslot.all
    end
  end
end
