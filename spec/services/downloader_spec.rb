require "rails_helper"

RSpec.describe Downloader do
  let(:dir) { Rails.root.join("tmp").to_s }
  let(:filename) { File.join(dir, "repodata.tar.gz") }
  let(:url) { "https://example.com/repodata" }

  subject(:downloader) { Downloader.new(dir: dir, url: url) }

  describe "#download" do
    it "shells out to curl" do
      allow(downloader).to receive(:system).
        with("curl", "--silent", "--output", filename, url)

      downloader.download

      expect(downloader).to have_received(:system)
    end
  end

  describe "#extract" do
    it "" do
      allow(downloader).to receive(:system).
        with("tar", "xf", filename, "--directory", dir)

      downloader.extract

      expect(downloader).to have_received(:system)
    end
  end
end
