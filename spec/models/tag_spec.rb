require "rails_helper"

RSpec.describe Tag, type: :model do
  describe "#name" do
    subject {FactoryGirl.create :tag}

    before {subject.name = "  "}
    it {is_expected.not_to be_valid}
  end
end
