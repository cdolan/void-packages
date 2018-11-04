require "rails_helper"

RSpec.describe Package, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:builds) }
    it { is_expected.to have_many(:arches).through(:builds) }
  end

  describe "validations" do
    subject do
      Package.new do |p|
        p.name = "foo"
        p.license = "bar"
        p.version = "1.0.0"
        p.revision = 1
      end
    end

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_presence_of(:license) }
    it { is_expected.to validate_presence_of(:version) }
    it { is_expected.to validate_presence_of(:revision) }

    it do
      is_expected.to validate_numericality_of(:revision).
        only_integer.is_greater_than_or_equal_to(1)
    end
  end
end
