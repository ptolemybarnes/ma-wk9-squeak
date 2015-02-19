
FactoryGirl.define do
  factory :user do
    email "user@email.com"
    password 'password1234'
    password_confirmation { "#{password}"}
  end 

  factory :restaurant do
    name 'The Fat Duck'
    rating 3
    association :user 
  end

  factory :review do
    thoughts 'lovely atmosphere'
    rating  4
    restaurant 
  end
    
end
