require "test_helper"

class CityTest < ActiveSupport::TestCase
  setup do
    @city_attributes = {
      latitude: 48.582213345751434,
      longitude: 7.750986089307696,
      capital: 'Strasbourg',
      country: 'France'
    }
  end

  test 'success to create city' do
    city = City.new(@city_attributes)
    assert(city.save)
  end

  test 'success to have keywords from city data' do
    city = City.new(@city_attributes)
    assert_equal(city.keywords.size, 2)
  end

  test 'fails to save already existing city' do
    city = City.create(@city_attributes)
    assert_raises(ActiveRecord::RecordNotUnique) { city.dup.save }
  end

  test 'fails to save city with non-numeric latitude' do
    city = City.new(@city_attributes.merge(latitude: 'latitude'))
    assert(!city.save)
    assert_not_empty(city.errors)

    assert(city.errors.any? { |error|
      error.attribute == :latitude && error.type == :not_a_number
    })
  end

  test 'fails to save city with non-numeric longitude' do
    city = City.new(@city_attributes.merge(longitude: 'longitude'))
    assert(!city.save)
    assert_not_empty(city.errors)

    assert(city.errors.any? { |error|
      error.attribute == :longitude && error.type == :not_a_number
    })
  end

  test 'fails to save city if any attribute is empty' do
    attributes = {}
    keys = @city_attributes.keys

    keys.size.times.each do |index|
      city = City.new(attributes)
      assert(!city.save)
      assert_not_empty(city.errors)

      attributes[keys[index]] = @city_attributes[keys[index]]
    end
  end
end
