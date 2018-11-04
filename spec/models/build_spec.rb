require "rails_helper"

RSpec.describe Build, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:arch) }
    it { is_expected.to belong_to(:package) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:filename_sha256) }
    it { is_expected.to validate_presence_of(:filename_size) }
    it { is_expected.to validate_presence_of(:installed_size) }
    it { is_expected.to validate_presence_of(:installed_size) }

    it do
      is_expected.to validate_numericality_of(:filename_size).
        only_integer.is_greater_than_or_equal_to(0)
    end

    it do
      is_expected.to validate_numericality_of(:installed_size).
        only_integer.is_greater_than_or_equal_to(0)
    end
  end
end
