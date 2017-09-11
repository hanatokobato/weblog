require "rails_helper"

RSpec.describe Post, type: :model do
  let :user {FactoryGirl.create :user}

  describe "#title" do
    subject {FactoryGirl.create :post, user: user}

    before {subject.title = "   "}
    it {is_expected.not_to be_valid}
  end

  describe "#body" do
    subject {FactoryGirl.create :post, user: user}

    before {subject.body = "   "}
    it {is_expected.not_to be_valid}
  end
end
