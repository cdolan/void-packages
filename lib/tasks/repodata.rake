namespace :repodata do
  desc "Import latest repodata"
  task import: :environment do
    yaml = YAML.load_file(Rails.root.join("config", "repodata.yml"))
    config = yaml.fetch(Rails.env)

    config.each do |arch_name, urls|
      arch = Arch.find_or_create_by!(name: arch_name)

      urls.each do |url|
        Importer.new(arch: arch, url: url).import
      end
    end
  end
end
