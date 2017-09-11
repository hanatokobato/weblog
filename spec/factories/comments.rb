FactoryGirl.define do
  factory :comment do
    content "MyText"
    commentable_id 1
    commentable_type "Post"
    user nil
  end
end
