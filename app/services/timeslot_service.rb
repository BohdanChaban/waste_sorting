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
      timeslot = Timeslot.select { |t| t.district == @user.account.district }.reject(&:max_count_inquiry?)
      timeslot.present? ? timeslot : Timeslot.all
    end
  end
end
