FactoryBot.define do
  factory :product do
    name { 'Product test' }
    user

    trait :without_user do
      add_attribute(:user) { nil }
    end
  end
end
