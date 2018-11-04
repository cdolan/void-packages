class Repodata
  def initialize(dir)
    @filename = File.join(dir, "index.plist")
  end

  def index_plist
    @index_plist ||= Plist.parse_xml(filename).to_h
  end

  private

  attr_reader :filename
end
