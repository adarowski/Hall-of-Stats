FactoryGirl.define do
  factory :article do
    title 'Some title'
    body  'Some body'

    factory :unpublished_article do
      published false
    end

    factory :published_article do
      published true
      published_at { Time.now }
    end
  end
end
