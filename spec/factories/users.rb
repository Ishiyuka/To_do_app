FactoryBot.define do
  factory :user do
    name { "admin0test1" }
    email { "admin0test1@example.com" }
    password { "admin0test1" }
    password_confirmation { "admin0test1" }
    admin { true }
  end

  factory :second_user, class: User do
    name { "Test04" }
    email { "test04@example.com" }
    password { "test04" }
    password_confirmation { "test04" }
    admin { false }
  end
end
