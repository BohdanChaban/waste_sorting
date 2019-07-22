class TimeslotService
  def initialize(user)
    @user = user
  end

  def check_role
    if @user.role == 'manager'
      @user.timeslots
    elsif @user.role == 'customer'
      Timeslot.select { |t| t.district.city == @user.account.city }
    elsif @user.role == 'admin'
      Timeslot.all
    end
  end
end
