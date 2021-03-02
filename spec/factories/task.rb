FactoryBot.define do
  factory :task do
    title { 'test1' }
    content { 'sample1' }
    deadline { '2021-01-01' }
    status { 0 }
    priority { 0 }
    association :user
  end
  factory :second_task, class: Task do
    title { 'test2' }
    content { 'sample2' }
    deadline { '2020-01-01' }
    status { 1 }
    priority { 1 }
    association :user, factory: :second_user
  end
  factory :third_task, class: Task do
    title { 'test3' }
    content { 'sample3' }
    deadline { '2022-01-01' }
    status { 2 }
    priority { 2 }
    association :user, factory: :third_user
  end
end