class Downloader
  def initialize(dir:, url:)
    @dir = dir
    @url = url
    @filename = File.join(dir, "repodata.tar.gz")
  end

  def download
    system "curl", "--silent", "--output", filename, url
  end

  def extract
    system "tar", "xf", filename, "--directory", dir
  end

  private

  attr_reader :dir, :url, :filename
end
