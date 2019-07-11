RSpec.describe ApplicationController, type: :controller  do
    
  let(:account) { FactoryBot.create(:account) }
  let(:user) { FactoryBot.create(:user) }
  
  it "returns new account" do
    login_with user
    expect(response).to redirect_to new_account_path
  end

  it "returns new account" do
    login_with account
    expect(response).to redirect_to root_path
  end

end