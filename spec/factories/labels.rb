FactoryBot.define do
  factory :study_label, class:Label do
    label_name { "study" }
  end
  factory :music_label, class: Label do
    label_name { "music" }
  end
end
