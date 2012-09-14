FactoryGirl.define do
  factory :player do
    sequence(:id) {|n| "abcdefg#{n}" }
  end
end
