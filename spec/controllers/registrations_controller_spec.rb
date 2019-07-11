RSpec.describe RegistrationsController, type: :controller  do
    
  
  let(:user) { FactoryBot.create(:user) }
  
  it "returns new account" do
    sign_in user
    expect(response).to redirect_to new_account_path
    end
end