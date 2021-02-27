FactoryBot.define do
  factory :user do
    name { "general_user" }
    email { "general@example.com" }
    password { "password" }
    password_confirmation { "password" }
    admin { false }
  end
  factory :admin_user, class: User do
    name { "admin_user" }
    email { "admin@example.com" }
    password { "password" }
    password_confirmation { "password" }
    admin { true }
  end
  factory :second_user, class: User do
    name { "second_user" }
    email { "second@example.com" }
    password { "password" }
    password_confirmation { "password" }
    admin { false }
  end
  factory :third_user, class: User do
    name { "third_user" }
    email { "third@example.com" }
    password { "password" }
    password_confirmation { "password" }
    admin { false }
  end
end
