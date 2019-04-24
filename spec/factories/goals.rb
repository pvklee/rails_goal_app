FactoryBot.define do
  factory :goal do
    goal_title { Faker::IndustrySegments.industry }
    goal_description { Faker::IndustrySegments.sector }
    is_private { false }
    is_completed { false }
  end
end
