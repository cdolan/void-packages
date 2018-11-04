require "rails_helper"

RSpec.describe Arch, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:builds) }
    it { is_expected.to have_many(:packages).through(:builds) }
  end

  describe "validations" do
    subject { Arch.new(name: "foo") }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
