class RequestService
  def initialize(user)
    @user = user
  end

  def call
    if @user&.admin?
      Request.all
    elsif @user&.manager?
      @user.requests
    elsif @user&.customer?
      @user.requests
    end
  end
end
