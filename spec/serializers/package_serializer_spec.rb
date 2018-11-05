require "rails_helper"

RSpec.describe PackageSerializer do
  let(:package) do
    Package.new do |p|
      p.id = 42
      p.name = "foo"
      p.license = "bar"
      p.version = "1.2.3"
      p.revision = 1
    end
  end

  subject(:serializer) { PackageSerializer.new(package) }

  describe "#serialized_json" do
    it do
      json = JSON.parse(serializer.serialized_json)

      expect(json["data"]).to include({
        "type" => "package",
        "id" => "42",
        "attributes" => {
          "name" => "foo"
        }
      })
    end
  end
end
