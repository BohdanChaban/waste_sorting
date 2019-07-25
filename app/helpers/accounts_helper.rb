module AccountsHelper
  def show_user_role(account)
    User.all.each do |user|
      return user.role if user.id == account
    end
  end
end
