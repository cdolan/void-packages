class SearchesController < ApplicationController
  RESULTS = 5

  def new
    respond_to do |format|
      format.html
      format.json do
        render json: PackageSerializer.new(packages).serialized_json
      end
    end
  end

  private

  def packages
    query = params[:q]

    Package.all.sort_by do |pkg|
      -JaroWinkler.jaro_distance(pkg.name, query)
    end.slice(0, RESULTS)
  end
end
