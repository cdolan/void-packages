require "rails_helper"

RSpec.describe Importer do
  let(:arch) { Arch.create!(name: "x86_64") }
  let(:url) { "https://example.com/repodata" }

  subject(:importer) { Importer.new(arch: arch, url: url) }

  describe "#import" do
    before do
      stub_downloader
      stub_repodata
    end

    it "creates Package records" do
      importer.import

      expect(Package.count).to eq(1)
    end

    it "creates Build records" do
      importer.import

      expect(Build.count).to eq(1)
    end

    it "does not create duplicates" do
      3.times { importer.import }

      expect(Package.count).to eq(1)
      expect(Build.count).to eq(1)
    end
  end

  def stub_downloader
    instance_double(Downloader).tap do |downloader|
      allow(Downloader).to receive(:new).and_return(downloader)
      allow(downloader).to receive(:download)
      allow(downloader).to receive(:extract)
    end
  end

  def stub_repodata
    instance_double(Repodata).tap do |repodata|
      index_plist = Plist.parse_xml(file_fixture("index.plist")).to_h
      allow(Repodata).to receive(:new).and_return(repodata)
      allow(repodata).to receive(:index_plist).and_return(index_plist)
    end
  end
end
