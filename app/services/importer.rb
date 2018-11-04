class Importer
  def initialize(arch:, url:)
    @arch = arch
    @url = url
  end

  def import
    Dir.mktmpdir do |dir|
      downloader = Downloader.new(dir: dir, url: url)
      downloader.download
      downloader.extract

      repodata = Repodata.new(dir)

      packages = repodata.index_plist.map do |name, data|
        re = /#{Regexp.escape(name)}-(?<version>.+)_(?<revision>\d+)/
        match = re.match(data["pkgver"])

        Package.new do |p|
          p.name = name
          p.homepage = data["homepage"]
          p.license = data["license"]
          p.version = match[:version]
          p.revision = match[:revision].to_i
          p.maintainer = data["maintainer"]
          p.description = data["short_desc"]
          p.source_revision = data["source-revisions"]
        end
      end

      Package.import! packages,
        synchronize: packages,
        on_duplicate_key_update: {
          conflict_target: %i[name],
          columns: :all
        }

      builds = packages.map do |package|
        data = repodata.index_plist[package.name]

        Build.new do |bp|
          bp.arch = arch
          bp.package = package
          bp.build_date = Time.parse(data["build-date"])
          bp.filename_sha256 = data["filename-sha256"]
          bp.filename_size = data["filename-size"]
          bp.installed_size = data["installed_size"]
        end
      end

      Build.import! builds,
        on_duplicate_key_update: {
          conflict_target: %i[arch_id package_id],
          columns: :all
        }
    end
  end

  private

  attr_reader :arch, :url
end
