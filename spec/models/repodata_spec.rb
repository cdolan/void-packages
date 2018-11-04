require "rails_helper"

RSpec.describe Repodata do
  describe "#index_plist" do
    it "returns Hash of property list" do
      repodata = Repodata.new(file_fixture("index.plist").dirname)

      expect(repodata.index_plist).to have_key("ruby")
    end
  end
end
