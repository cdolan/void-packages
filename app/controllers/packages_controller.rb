class PackagesController < ApplicationController
  def show
    @package = Package.includes(:builds, :arches).find_by!(name: params[:name])
  end
end
