FactoryBot.define do
  factory :user do
    email { 'test@test.com' }
    password { 'Testy1234!' }
    password_confirmation { 'Testy1234!' }
    role { 'user' }
  end
end
