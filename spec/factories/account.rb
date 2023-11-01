FactoryBot.define do
  factory :account, class: Account do
    first_name { Faker::Name.unique.first_name }
    last_name { Faker::Name.unique.last_name }
    email { Faker::Internet.unique.email }
    password {'TestPassword@123'}
    
    activated { true }
  end
end
