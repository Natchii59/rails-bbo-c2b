require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { FactoryBot.create(:product) }
  let(:product_without_user) { FactoryBot.build(:product, :without_user) }

  it 'should valid product' do
    expect(product).to be_valid
  end

  it 'should invalid product without user' do
    expect(product_without_user).to be_invalid
  end
end
