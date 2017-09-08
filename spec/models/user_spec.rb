require "rails_helper"

RSpec.describe User, type: :model do
  describe "#name" do
    subject {FactoryGirl.create :user}

    before {subject.name = ""}
    it {is_expected.not_to be_valid}
  end

  describe "#email" do
    context "email length" do
      subject {FactoryGirl.create :user}

      before {subject.email = "a" * 244 + "@example.com"}
      it {is_expected.not_to be_valid}
    end

    context "email regex" do
      subject {FactoryGirl.create :user}

      before {subject.email = "user@example,com"}
      it {is_expected.not_to be_valid}
    end

    context "email should be unique" do
      subject {FactoryGirl.create(:user).dup}

      before {subject.email.upcase!}
      it {is_expected.not_to be_valid}
    end
  end

  describe "#password" do
    context "password nonblank" do
      subject {FactoryGirl.create :user}

      before {subject.password = subject.password_confirmation = "    "}
      it {is_expected.not_to be_valid}
    end

    context "password should have a minimum length" do
      subject {FactoryGirl.create :user}

      before {subject.password = subject.password_confirmation = "a" * 5}
      it {is_expected.not_to be_valid}
    end
  end
end
