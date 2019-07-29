class InquiryService
  def initialize(user)
    @user = user
  end

  def call
    if @user&.admin?
      Inquiry.all
    elsif @user&.manager?
      inquiry = @user.timeslots.map { |t| t.inquiries.map { |i| i } }
      inquiry.flatten
    elsif @user&.customer?
      @user.timeslots.inquiries
    end
  end
end
