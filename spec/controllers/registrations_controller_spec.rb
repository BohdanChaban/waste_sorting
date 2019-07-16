require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  controller do
    def after_sign_up_path_for(resource)
      super resource
    end
  end

  let(:user) { FactoryBot.create(:user) }

  it 'returns new account path' do
    expect(controller.after_sign_up_path_for(user))
      .to eq new_account_path
  end
end
