FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :micropost do
    content "Lorem ipsum"
    user
  end

  factory :forecast do
    sensible "Snow"
    hi_temp 28
    lo_temp 22
    ws 12
    wd 315
    precip_chance 90
    qpf 0.75
    user
  end
end

