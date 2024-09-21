class CitiesController < ApplicationController
  include TravelRange::GreatCircle

  def index
    @cities = load_cities

    respond_to do |format|
      format.html
      format.json { render json: CitySerializer.new(@cities).serializable_hash }
    end
  end

  private
  def search_params
    params.delete(:commit)
    params.permit(:lat, :lon, :radius)
  end

  ##
  # Load cities
  def load_cities
    return [] unless %i(lat lon radius).all? { |p| search_params[p].present? }

    lat = search_params[:lat].to_d
    lon = search_params[:lon].to_d
    radius = search_params[:radius].to_d

    distance = Distance.new(lat, lon)

    City.all.select { |city|
      city_distance = distance.compute(city.latitude, city.longitude, Unit::KILOMETER)
      in_range = city_distance <= radius
      city.distance = city_distance if in_range
      in_range
    }.sort_by(&:distance)
  end
end
