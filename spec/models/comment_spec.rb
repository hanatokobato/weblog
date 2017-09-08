require "rails_helper"

RSpec.describe Comment, type: :model do
  let :user {FactoryGirl.create :user}
  let :post {FactoryGirl.create :post, user: user}

  describe "#content" do
    subject {FactoryGirl.create :comment, user: user, commentable: post}

    before {subject.content = "   "}
    it {is_expected.not_to be_valid}
  end
end
