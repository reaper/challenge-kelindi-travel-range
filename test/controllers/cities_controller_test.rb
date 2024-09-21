require "test_helper"

class CitiesControllerTest < ActionDispatch::IntegrationTest
  test 'success to get cities' do
    get cities_url
    assert_response :success
    assert_select(".cities", 0)
  end

  test 'success to query cities in specific range' do
    Rails.application.load_seed
    wanted_cities = ['Saint Helier', 'St Peter Port', 'Paris', 'London', 'Brussels', 'Luxembourg']

    get cities_url(format: :json, lat: 48.08, lon: -1.68, radius: 600)
    assert_response :success

    data = JSON.parse(response.body).with_indifferent_access
    cities = data[:data]

    # test presence (almost sort too)
    assert_equal(cities.map { |city| city.dig(:attributes, :capital) }, wanted_cities)

    # test sort
    city_distances = cities.map { |city| city.dig(:attributes, :distance).to_d }
    assert_equal(city_distances, city_distances.sort)
  end
end
