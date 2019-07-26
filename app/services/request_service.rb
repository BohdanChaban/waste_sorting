class RequestService
  def initialize(user)
    @user = user
  end

  def call
    if @user&.admin?
      Request.all
    elsif @user&.manager?
      request = @user.timeslots.map { |t| t.requests.map { |r| r } }
      request.flatten
    elsif @user&.customer?
      @user.requests
    end
  end
end
