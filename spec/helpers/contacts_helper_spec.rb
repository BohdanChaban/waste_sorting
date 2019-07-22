require 'rails_helper'

RSpec.describe ContactsHelper, type: :helper do
  describe '#show_non_blank_field' do
    let!(:contact) { FactoryBot.create(:contact_valid_attributes) }

    let(:label) do
      { address: 'Address',
        fb: 'Facebook' }
    end

    let(:non_link_field) { "<tr><th>#{label[:address]}:</th><td>#{contact.address}</td></tr>" }
    let(:link_field) { "<tr><th>#{label[:fb]}:</th><td><a href=#{contact.facebook}>#{contact.facebook}</a></td></tr>" }
    context 'shows non_blank_field' do
      it 'without hyperlinks' do
        expect(helper.show_non_blank_field(label[:address], contact.address)).to eql non_link_field
      end
      it 'with hyperlink' do
        expect(helper.show_non_blank_field(label[:fb], contact.facebook)).to eql link_field
      end
    end
  end
end
