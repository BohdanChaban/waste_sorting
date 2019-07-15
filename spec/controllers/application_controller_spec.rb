require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def after_sign_in_path_for(resource)
      super resource
    end
  end
  let(:account) { FactoryBot.create(:account) }
  let(:user) { FactoryBot.create(:user) }

  it 'returns new account path' do
    login_with user
    expect(controller.after_sign_in_path_for(user))
      .to eq(new_account_path)
  end
  context 'user with account' do
    let(:user) { FactoryBot.create(:user, account: account) }
    it 'returns root path' do
      login_with user
      expect(controller.after_sign_in_path_for(user)).to eq(root_path)
    end
  end
end
